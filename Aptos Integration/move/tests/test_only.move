#[test_only]
module AptosAncestry::test_only {
    use std::signer;
    use std::string;
    use aptos_framework::account;
    use aptos_framework::timestamp;
    use AptosAncestry::PrivacyEnhancedFamilyHealth;

    // Test account addresses
    const ADMIN: address = @0x1;
    const USER1: address = @0x2;
    const USER2: address = @0x3;

    // Helper function to create test accounts
    fun create_test_accounts(): (signer, signer, signer) {
        let admin = account::create_account_for_test(ADMIN);
        let user1 = account::create_account_for_test(USER1);
        let user2 = account::create_account_for_test(USER2);
        (admin, user1, user2)
    }

    // Helper function to initialize timestamp
    fun initialize_timestamp() {
        let timestamp_account = account::create_account_for_test(@aptos_framework); // Ensure @aptos_framework is valid
        timestamp::set_time_has_started_for_testing(&timestamp_account);
    }

    #[test]
    fun test_initialize_family_tree() {
        let (admin, _, _) = create_test_accounts();
        initialize_timestamp();
        PrivacyEnhancedFamilyHealth::initialize_family_tree(&admin);
        // We can't assert initialization directly, but we can add a family member to check indirectly
        let name = string::utf8(b"TestMember");
        let relation = string::utf8(b"Test");
        let encrypted_medical_history = b"test_data";
        let nonce = b"test_nonce";
        PrivacyEnhancedFamilyHealth::add_family_member(&admin, name, relation, encrypted_medical_history, nonce);
    }

    #[test]
    fun test_add_family_member() {
        let (admin, user1, _) = create_test_accounts();
        initialize_timestamp();
        PrivacyEnhancedFamilyHealth::initialize_family_tree(&admin);

        let name = string::utf8(b"Alice");
        let relation = string::utf8(b"Mother");
        let encrypted_medical_history = b"encrypted_data";
        let nonce = b"nonce_data";
        
        PrivacyEnhancedFamilyHealth::add_family_member(
            &admin, 
            name, 
            relation, 
            encrypted_medical_history, 
            nonce
        );

        // Grant access to USER1
        let encrypted_symmetric_key = b"encrypted_key";
        PrivacyEnhancedFamilyHealth::grant_access(
            &admin, 
            name, 
            signer::address_of(&user1), 
            encrypted_symmetric_key
        );

        // Retrieve data with proper authorization
        let (retrieved_data, retrieved_nonce, _) = PrivacyEnhancedFamilyHealth::get_health_data(&user1, signer::address_of(&admin), name);
        assert!(retrieved_data == encrypted_medical_history, 0);
        assert!(retrieved_nonce == nonce, 1);
    }

    #[test]
    fun test_grant_access() {
        let (admin, user1, _) = create_test_accounts();
        initialize_timestamp();
        PrivacyEnhancedFamilyHealth::initialize_family_tree(&admin);

        let name = string::utf8(b"Alice");
        let relation = string::utf8(b"Mother");
        let encrypted_medical_history = b"encrypted_data";
        let nonce = b"nonce_data";
        
        PrivacyEnhancedFamilyHealth::add_family_member(
            &admin, 
            name, 
            relation, 
            encrypted_medical_history, 
            nonce
        );
        
        let encrypted_symmetric_key = b"encrypted_key";
        PrivacyEnhancedFamilyHealth::grant_access(
            &admin, 
            name, 
            signer::address_of(&user1), 
            encrypted_symmetric_key
        );

        // Retrieve data and check assertions
        let (retrieved_data, retrieved_nonce, _) = PrivacyEnhancedFamilyHealth::get_health_data(&user1, signer::address_of(&admin), name);
        assert!(retrieved_data == encrypted_medical_history, 0);
        assert!(retrieved_nonce == nonce, 1);
    }

    #[test]
    fun test_update_health_data() {
        let (admin, user1, _) = create_test_accounts();
        initialize_timestamp();
        PrivacyEnhancedFamilyHealth::initialize_family_tree(&admin);

        let name = string::utf8(b"Alice");
        let relation = string::utf8(b"Mother");
        let encrypted_medical_history = b"encrypted_data";
        let nonce = b"nonce_data";
        
        PrivacyEnhancedFamilyHealth::add_family_member(
            &admin, 
            name, 
            relation, 
            encrypted_medical_history, 
            nonce
        );

        let new_encrypted_medical_history = b"new_encrypted_data";
        let new_nonce = b"new_nonce_data";
        
        PrivacyEnhancedFamilyHealth::update_health_data(
            &admin, 
            name, 
            new_encrypted_medical_history, 
            new_nonce
        );

        // Grant access to USER1 before retrieval
        let encrypted_symmetric_key = b"encrypted_key";
        PrivacyEnhancedFamilyHealth::grant_access(
            &admin, 
            name, 
            signer::address_of(&user1), 
            encrypted_symmetric_key
        );

        let (retrieved_data, retrieved_nonce, _) = PrivacyEnhancedFamilyHealth::get_health_data(
            &user1, 
            signer::address_of(&admin), 
            name
        );
        assert!(retrieved_data == new_encrypted_medical_history, 0);
        assert!(retrieved_nonce == new_nonce, 1);
    }

     #[test]
    fun test_get_health_data() {
        let (admin, user1, _) = create_test_accounts();
        initialize_timestamp();
        PrivacyEnhancedFamilyHealth::initialize_family_tree(&admin);
        
        let name = string::utf8(b"Alice");
        let relation = string::utf8(b"Mother");
        let encrypted_medical_history = b"encrypted_data";
        let nonce = b"nonce_data";
        
        PrivacyEnhancedFamilyHealth::add_family_member(
            &admin, 
            name, 
            relation, 
            encrypted_medical_history, 
            nonce
        );
        
        let encrypted_symmetric_key = b"encrypted_key";
        PrivacyEnhancedFamilyHealth::grant_access(
            &admin, 
            name, 
            signer::address_of(&user1), 
            encrypted_symmetric_key
        );
        
        let (retrieved_data, retrieved_nonce, retrieved_key) = PrivacyEnhancedFamilyHealth::get_health_data(
            &user1, 
            signer::address_of(&admin), 
            name
        );
        assert!(retrieved_data == encrypted_medical_history, 0);
        assert!(retrieved_nonce == nonce, 1);
        assert!(retrieved_key == 0, 2); // Assuming 0 is the default value when no key is set
    }

    #[test]
    #[expected_failure(abort_code = PrivacyEnhancedFamilyHealth::E_NOT_AUTHORIZED)]
    fun test_unauthorized_access() {
        let (admin, _, user2) = create_test_accounts();
        initialize_timestamp();
        PrivacyEnhancedFamilyHealth::initialize_family_tree(&admin);

        let name = string::utf8(b"Alice");
        let relation = string::utf8(b"Mother");
        let encrypted_medical_history = b"encrypted_data";
        let nonce = b"nonce_data";
        
        PrivacyEnhancedFamilyHealth::add_family_member(
            &admin, 
            name, 
            relation, 
            encrypted_medical_history, 
            nonce
        );

        // This should fail because user2 is not authorized
        PrivacyEnhancedFamilyHealth::get_health_data(
            &user2, 
            signer::address_of(&admin), 
            name
        );
    }
}
