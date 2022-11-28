//unclear---Dry run needed
public class AccountContactCountUsingMap {
    Map<String,Integer> nmap;
    public List<AccountWrapper> accountWrapper{get;set;} 
    public AccountContactCountUsingMap(){
        accountWrapper= new List<AccountWrapper>();
        nmap = new Map<String,Integer>();
        fillWrapper();
    }
    
    public void fillWrapper(){
        Integer count = 0;
        for(Contact conrecord: [Select Id, AccountId FROM Contact]){
            if(conrecord.AccountId != null){
            count = nmap.get(conrecord.AccountId);
            }
            If(count==null){
                count=0;
            }
            count++;
            nmap.put(conrecord.AccountId,count);
        }
        INTEGER index=0;
        for(Account accRecord: [SELECT Id, Name FROM Account]){
            AccountWrapper accWrapperRecords = new AccountWrapper();
            accWrapperRecords.sNo = index;
            accWrapperRecords.Name = accRecord.Name;
            
            If(nmap.get(accRecord.Id)==null){
                accWrapperRecords.Count = 0;
            }
            else{
                accWrapperRecords.count = nmap.get(accRecord.Id);
            }
            index++;
            accountWrapper.add(accWrapperRecords);
        }
    }
    
    Public class AccountWrapper{
        public INTEGER sNo{get;set;}
        public String Name{get;set;}
        public Integer Count{get;set;}
        
        
    }
    
}