/*Trigger
* Created By  : Bhavika
* Description : When user update any info then we also update User's parent Contact. 
* Created on  : 18/11/2022
*/

trigger updateContactFromCommunities on User (after update) {
    
    if (Trigger.new.size() > 0 && !System.isFuture()) { //only run the logic when the trigger is fired from a single update and the update is not being fired from a future method
        //grab the User sObject
        List<user> users = new List<User>();
        for(User u : Trigger.new){
            if (u.ContactId != null) { //make sure there is an associated Contact
                users.add(u);
                system.debug('u=> '+u.contactId);
            }
        }
        updateContactWhenUserUpdate.updateContact(users); 
    
    }
}