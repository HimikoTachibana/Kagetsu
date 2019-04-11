# Known bugs

1. Chat system is not complete. There is a more progressed version in one of the branches (chats), but it still fully functional in the production environment. Due to mergining and time issues, we had to revert back to older implementation where other parts of the application is fairly stable.

2. There are some issues with the VM, where logo and some of images do not get loaded. In order to fix this, the "vagrant reload" and "vagrant provision" needs to be run several times.

3. The link to create chat through Friends List is currently linked to nowhere (since it is a placeholder for when the chat is actually working).



# Features

1. Access controls for user profile, and characters are implemented.

2. User can create accounts (sign up - proper validations are in place)

3. User can login/logout

3. User can view/edit profile details (including images)

4. User can view profile/characters/friends once authenticated (proper access controls are checked)

5. User can switch between characters, and this information is persistent over time. (the AJAX form allows to stay in page while the data is saved in the database).

6. User can view list of his own characters.

7. User can add/edit upto ten characters with images (proper validation is set to check the limit for corner cases as well)

8. User can delete characters

9. User can view list of friends

10. User can add/delete friends by searching all users.

11. Current friends are indicated with label on top-left.
