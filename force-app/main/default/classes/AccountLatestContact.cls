public class AccountLatestContact {
    public List<ConAccWrapper> wrapperClass{get;set;}
    public Map<String,String> nmap{get;set;}
    
    public AccountLatestContact(){
        wrapperClass  = new List<ConAccWrapper>();
        nmap = new Map<String,String>();
        fillWrapper();
    }
    
    public void fillWrapper()
    {
        
        for(Account accRecord: [SELECT Id, Name, (SELECT Name FROM Contacts ORDER BY CreatedDate DESC LIMIT 1) 
                                FROM Account])
        {
            ConAccWrapper wrapperRecord = new ConAccWrapper();
            If(accRecord.Contacts != null && accRecord.Contacts.size()>0){
                wrapperRecord.acName = accRecord.Name;
                nmap.put(accRecord.Name, accRecord.Contacts[0].Name);
                //system.debug('===='+accRecord.Contacts[0].Name);
                
                wrapperRecord.coname = nmap.get(accRecord.Name);
            }
         
            wrapperClass.add(wrapperRecord);
            system.debug('===>'+wrapperRecord);
            
        }
    }
    
    
    public class ConAccWrapper{
        
        public String acName{get;set;}
        public String coName{get;set;}
        
    }
}