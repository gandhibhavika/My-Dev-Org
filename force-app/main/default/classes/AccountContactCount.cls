public class AccountContactCount{
    
    public List<AccountWrapper> accountRecords{get;set;} 
    
    
    public  AccountContactCount(){
        accountRecords = new List<AccountWrapper>();
        fillWrapper();
    }
    public void fillWrapper(){
        Integer index = 1;
        Integer Count=1;
        List<Account> accRecords = [SELECT Id, Name, (SELECT Id FROM Contacts) FROM Account];
        for( Account accRecord : accRecords){
            AccountWrapper accWrapper = new AccountWrapper();
            accWrapper.sNo = index;
            accWrapper.Name = accRecord.Name;
            accWrapper.Count = accRecord.Contacts.size();

            accountRecords.add(accWrapper);
            index++;
            
        }
        
        
    }
    public class AccountWrapper{
      public  Integer sNo{get;set;}
      public  String Name{get;set;}
      public  Integer Count{get;set;}
        
    }
}