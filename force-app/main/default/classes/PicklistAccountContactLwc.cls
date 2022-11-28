public class PicklistAccountContactLwc {

@AuraEnabled(cacheable=true)
public static List<Account> getAccountRecords(){
return [SELECT Id, Name FROM Account];
}
 
 @AuraEnabled(cacheable=true)
 public static List<Contact> getContactRecords(String accId){
     return  [SELECT Id, Name FROM Contact WHERE AccountId =: accId];
   }

   @AuraEnabled(cacheable=true)
   public static List<Task>getTaskRecords(String conId){
       return [ SELECT Id, Subject,  ActivityDate, Status, CreatedById FROM Task WHERE WhoId =: conId];
   }
}