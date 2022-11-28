/*Trigger Handler
* Created By  : Bhavika
* Description : When user update any info then we also update User's parent Contact. 
* Created on  : 18/11/2022
*/

global class updateContactWhenUserUpdate {
    
    public static void updateContact(List<User> users) {
        Map<String,String> userContact = new Map<String,String>();  
        if (users.size() > 0) { //if there is a query result 
            for(CommunityContact__mdt comCont : [SELECT Contact__c , User__c FROM CommunityContact__mdt]) {
                userContact.put(comCont.Contact__c,comCont.User__c);
            }
        }
        List<Sobject> conList = new List<Contact>();
        system.debug('users Records==='+users);  
        for(User usr: Users ){
             Sobject con = new Contact(id = usr.ContactId);
            for(String key:userContact.keySet()){
               
                Switch on userContact.get(key){
                    when 'INTEGER'{
                        con.put(key,Integer.valueOf(usr.get(userContact.get(key))));
                    }
                    when 'DATE'{
                        con.put(key,Date.valueOf(String.valueOf(usr.get(userContact.get(key)))));
                    }
                    when else{
                        con.put(key,String.valueOf(usr.get(userContact.get(key))));
                    }
                }    
                
            }
            conList.add(con);
        }
        system.debug('Contact Records==='+conList);       
        UPDATE conList;
        system.debug('Contact Records==='+conList);       
    }
}




//Hard coded.
//provide all of the User details for the Contact update
/*Contact c = new Contact(Id = u.ContactId);
c.Email = u.Email;
c.FirstName = u.FirstName;
c.LastName = u.LastName;
c.MailingCity = u.City;
c.MailingCountry = u.Country;
c.MailingPostalCode = u.PostalCode;
c.MailingState = u.State;
c.MailingStreet = u.Street;
c.Phone = u.Phone;
c.Title = u.Title;*/
//update c; //update the contact record