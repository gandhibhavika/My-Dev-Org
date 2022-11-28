public class LwcAccountContactCount {

@AuraEnabled(cacheable = true)
     public static List<AccountContact> fillWrapper(){
         List<AccountContact> accContWrapper = new List<AccountContact>();
        for(Account accRecord : [SELECT Id, Name,(SELECT Id FROM Contacts) FROM Account]){
            AccountContact contactRecords = new AccountContact();
            if(accRecord.Contacts.size() > 0 && accRecord.Contacts != null){
                contactRecords.Id = accRecord.Id;  
                contactRecords.accName = accRecord.Name;  
                contactRecords.countCon = accRecord.Contacts.size();
                accContWrapper.add(contactRecords);
            }
        }
        return accContWrapper;
    }

    public class AccountContact{
        @AuraEnabled
        public String Id{get;set;}
        @AuraEnabled
        public String accName{get;set;}
        @AuraEnabled
        public Contact conRecords{get;set;}
        @AuraEnabled
        public Integer countCon{get;set;}
    }
}