public class ConcatAccountAndChildContactName {
    
    public List<accountContactWrapper> wrapperRecords{get;set;}
    
    public ConcatAccountAndChildContactName(){
        wrapperRecords = new List<accountContactWrapper>();
        fillWrapper();
    }
    
    public void fillWrapper(){
        for(Account accRec : [SELECT Id, Name,(SELECT Id, Name FROM Contacts) FROM Account]){
            if(accRec.Contacts.size() > 0 && accRec.Contacts != null){
                accountContactWrapper accConWrapp = new accountContactWrapper();
                accConWrapp.accountName = accRec.Name;
                accConWrapp.concated = accConWrapp.accountName;
                for(Integer i=0; i < accRec.Contacts.size(); i++){
                    accConWrapp.contactName = accRec.Contacts[i].Name;
                    accConWrapp.concated = accConWrapp.concated + accConWrapp.contactName;
                }
                accConWrapp.conCount = accRec.Contacts.size();                
                wrapperRecords.add(accConWrapp);
            }
        }
    }
    
    public class accountContactWrapper{
        public String accountName{get;set;}
        public String contactName{get;set;}
        public String concated{get;set;}
        public Integer conCount{get;set;}
        
    }
}