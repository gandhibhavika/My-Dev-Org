/*Trigger
* Created By  : Bhavika
* Description : When user update any info then we also update User's parent Contact. 
* Created on  : 18/11/2022
*/

trigger UserTrigger on User (after update, after insert) {
    if(trigger.isAfter && trigger.isUpdate){
        if (Trigger.new.size() > 0 && !System.isFuture()) { //only run the logic when the trigger is fired from a single update and the update is not being fired from a future method
            //grab the User sObject
            List<user> users = new List<User>();
            for(User u : Trigger.new){
                if (u.ContactId != null) { //make sure there is an associated Contact
                    users.add(u);
                    system.debug('u=> '+u.contactId);
                }
            }
            if(users.size()>0 && UpdateContactToUser.updateContact != false){
                system.debug('entered......');
                updateCommunityUserToContact.updateContact(users); 
            }
        }
    }
    
    if(trigger.isAfter && trigger.isInsert && trigger.new.size()>0){
        for(User usr : trigger.new){
            if(usr.ProfileId == '00e5i000000lq2zAAA'){
                PermissionSetAssignment psa = new PermissionSetAssignment();
                psa.PermissionSetGroupId = '0PG5i0000008dABGAY';
                psa.AssigneeId = usr.Id;
            }
        } 
    }
        }