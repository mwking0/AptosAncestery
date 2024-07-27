module AptosAncestry::PrivacyEnhancedFamilyHealth {
    use std::string::{Self, String};
    use aptos_framework::account;
    use aptos_framework::event;
    use aptos_framework::timestamp;
    use aptos_std::table::{Self, Table};
    use aptos_framework::signer;

    // Structures
    struct EncryptedData has store, drop {
        ciphertext: vector<u8>,
        nonce: vector<u8>,
    }

    struct HealthRecord has store, drop {
        encrypted_medical_history: EncryptedData,
        last_updated: u64,
    }

    struct FamilyMember has key, store {
        name: String,
        relation: String,
        health_record: HealthRecord,
        access_control: Table<address, vector<u8>>, // Stores encrypted symmetric keys for authorized users
    }

    struct FamilyTree has key {
        members: Table<String, FamilyMember>,
        admin: address,
    }

    // Events
    struct HealthUpdateEvent has drop, store {
        member_name: String,
        update_type: String,
    }

    // Event handles
    struct EventHandles has key {
        health_update_events: event::EventHandle<HealthUpdateEvent>,
    }

    // Errors
    const E_NOT_AUTHORIZED: u64 = 1;
    const E_MEMBER_NOT_FOUND: u64 = 2;

    // Initialize family tree
    public fun initialize_family_tree(account: &signer) {
        let addr = signer::address_of(account);
        
        let family_tree = FamilyTree {
            members: table::new(),
            admin: addr,
        };
        move_to(account, family_tree);

        let handles = EventHandles {
            health_update_events: account::new_event_handle<HealthUpdateEvent>(account),
        };
        move_to(account, handles);
    }

    // Add family member with encrypted data
    public fun add_family_member(
        account: &signer,
        name: String,
        relation: String,
        encrypted_medical_history: vector<u8>,
        nonce: vector<u8>,
    ) acquires FamilyTree {
        let addr = signer::address_of(account);
        let family_tree = borrow_global_mut<FamilyTree>(addr);
        
        assert!(family_tree.admin == addr, E_NOT_AUTHORIZED);

        let health_record = HealthRecord {
            encrypted_medical_history: EncryptedData { ciphertext: encrypted_medical_history, nonce: nonce },
            last_updated: timestamp::now_seconds(),
        };

        let new_member = FamilyMember {
            name: name,
            relation: relation,
            health_record: health_record,
            access_control: table::new(),
        };

        table::add(&mut family_tree.members, name, new_member);
    }

    // Grant access to a specific user
    public fun grant_access(
        account: &signer,
        member_name: String,
        user_address: address,
        encrypted_symmetric_key: vector<u8>,
    ) acquires FamilyTree {
        let addr = signer::address_of(account);
        let family_tree = borrow_global_mut<FamilyTree>(addr);
        
        assert!(family_tree.admin == addr, E_NOT_AUTHORIZED);
        assert!(table::contains(&family_tree.members, member_name), E_MEMBER_NOT_FOUND);

        let member = table::borrow_mut(&mut family_tree.members, member_name);
        table::upsert(&mut member.access_control, user_address, encrypted_symmetric_key);
    }

    // Update health data (only accessible by admin)
    public fun update_health_data(
        account: &signer,
        member_name: String,
        new_encrypted_medical_history: vector<u8>,
        nonce: vector<u8>,
    ) acquires FamilyTree, EventHandles {
        let addr = signer::address_of(account);
        let family_tree = borrow_global_mut<FamilyTree>(addr);
        
        assert!(family_tree.admin == addr, E_NOT_AUTHORIZED);
        assert!(table::contains(&family_tree.members, member_name), E_MEMBER_NOT_FOUND);

        let member = table::borrow_mut(&mut family_tree.members, member_name);
        member.health_record = HealthRecord {
            encrypted_medical_history: EncryptedData { ciphertext: new_encrypted_medical_history, nonce: nonce },
            last_updated: timestamp::now_seconds(),
        };

        // Emit event
        let handles = borrow_global_mut<EventHandles>(addr);
        event::emit_event(&mut handles.health_update_events, HealthUpdateEvent { 
            member_name, 
            update_type: string::utf8(b"Health Data Update")
        });
    }

    // Get encrypted health data (only accessible by authorized users)
    public fun get_health_data(
        account: &signer,
        family_tree_owner: address,
        member_name: String
    ): (vector<u8>, vector<u8>, u64) acquires FamilyTree {
        let addr = signer::address_of(account);
        let family_tree = borrow_global<FamilyTree>(family_tree_owner);
        
        assert!(table::contains(&family_tree.members, member_name), E_MEMBER_NOT_FOUND);

        let member = table::borrow(&family_tree.members, member_name);
        assert!(table::contains(&member.access_control, addr), E_NOT_AUTHORIZED);

        (
            member.health_record.encrypted_medical_history.ciphertext,
            member.health_record.encrypted_medical_history.nonce,
            member.health_record.last_updated
        )
    }

    // Get encrypted symmetric key (for authorized users to decrypt data)
    public fun get_encrypted_symmetric_key(
        account: &signer,
        family_tree_owner: address,
        member_name: String
    ): vector<u8> acquires FamilyTree {
        let addr = signer::address_of(account);
        let family_tree = borrow_global<FamilyTree>(family_tree_owner);
        
        assert!(table::contains(&family_tree.members, member_name), E_MEMBER_NOT_FOUND);

        let member = table::borrow(&family_tree.members, member_name);
        assert!(table::contains(&member.access_control, addr), E_NOT_AUTHORIZED);

        *table::borrow(&member.access_control, addr)
    }
}
