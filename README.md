
![Example Image](/images/smart_contract.jpg)
Smart contract documentation 
Purpose:
This smart contract implements a privacy-enhanced family health record system on the Aptos blockchain. It allows for secure storage and sharing of encrypted health data among family members and authorized users.
Key Structures:

EncryptedData: Stores encrypted information and its nonce.
HealthRecord: Contains encrypted medical history and last update timestamp.
FamilyMember: Represents a family member with their health record and access control.
FamilyTree: The main structure holding all family members and the admin address.


Main Functions:

initialize_family_tree: Sets up the initial family tree structure.
add_family_member: Adds a new family member with encrypted health data.
grant_access: Gives access to a specific user by storing their encrypted symmetric key.
update_health_data: Updates the health data for a family member (admin only).
get_health_data: Retrieves encrypted health data (only for authorized users).
get_encrypted_symmetric_key: Retrieves the encrypted symmetric key for an authorized user.


Privacy and Security Features:

All medical data is stored in an encrypted format.
Access control is implemented using encrypted symmetric keys for each authorized user.
Only the admin can add family members and grant access to users.
Users can only access data for which they have been explicitly granted permission.


Events:

HealthUpdateEvent is emitted when a health record is updated, providing transparency without revealing sensitive data.


##############################################################################################################################

documentation 
Purpose:
This test module verifies the functionality of the PrivacyEnhancedFamilyHealth smart contract. It includes tests for initializing the family tree, adding family members, granting access, updating health data, retrieving health data, and checking unauthorized access.
Test Setup:

Three test accounts are created: ADMIN, USER1, and USER2.
A helper function create_test_accounts() is used to create these test accounts.
Another helper function initialize_timestamp() is used to set up the timestamp for testing.


Key Tests:
a. test_initialize_family_tree: Verifies that the family tree can be initialized correctly.
b. test_add_family_member: Checks if a family member can be added and their data retrieved.
c. test_grant_access: Ensures that access can be granted to a user and they can retrieve data.
d. test_update_health_data: Verifies that health data can be updated and retrieved correctly.
e. test_get_health_data: Checks if health data can be retrieved correctly.
f. test_unauthorized_access: Verifies that unauthorized access is properly prevented.
Test Structure:
Each test follows a similar structure:

Set up test accounts and initialize the family tree.
Perform the operation being tested (e.g., add a family member, update health data).
Verify the results using assertions.


Error Handling:
The test_unauthorized_access test uses the #[expected_failure] attribute to check if the contract correctly prevents unauthorized access.
Data Verification:
The tests use simple byte strings for encrypted data and nonces. In a real-world scenario, these would be properly encrypted data.














# Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.

You don't have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn't feel obligated to use this feature. However we understand that this tool wouldn't be useful if you couldn't customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
