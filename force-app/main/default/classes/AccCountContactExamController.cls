public class AccCountContactExamController {
    public List<AccountContact> accContWrapper{get;set;}
    public boolean cBox{get;set;}
    
    public AccCountContactExamController(){
        accContWrapper = new List<AccountContact>();
        cBox = true;
        fillWrapper();
    }
    
    public void fillWrapper(){
        
        for(Account accRecord : [SELECT Id, Name,(SELECT Id FROM Contacts) FROM Account]){
            AccountContact contactRecords = new AccountContact();
            if(accRecord.Contacts.size() > 0 && accRecord.Contacts != null){
                contactRecords.accName = accRecord.Name;  
                contactRecords.countCon = accRecord.Contacts.size();
                accContWrapper.add(contactRecords);
            }
        }
    }
    
   public void handleClick(){
       if(cBox == true){
           cBox = true;
       }
       else{
           cBox = false;
       }
    }
    
    public class AccountContact{
        public String accName{get;set;}
        public Contact conRecords{get;set;}
        public Integer countCon{get;set;}
    }
}