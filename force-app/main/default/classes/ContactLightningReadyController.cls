public class ContactLightningReadyController {
    public List<SearchConWrapper> conRecordsWrapper{get;set;}
    public List<SelectOption> options{get;set;}
    public String chosenValue{get;set;}
    public String name{get;set;}
    public Integer chosenSize{get;set;}
    public List<SelectOption> pageSize{get;set;}
    private integer totalRecords = 0;       
    private integer index = 0;  
    String fname = '%' + name + '%';
    public Integer size{get;set;} 
    public List<Contact> conRecordsList{get;set;}
    public Integer noOfRecords{get; set;} 
    // private integer blockSize = 10;  
    public integer total_size; 
    List<Contact> contactList=[SELECT FirstName,LastName,Email,Phone FROM Contact];
    private integer totalRecs = contactList.size();
    
    
    public ContactLightningReadyController(){
        options = new List<SelectOption>();
        conRecordsList = new List<Contact>();
        pageSize = new List<SelectOption>();
        total_size = [select count() from Contact];
        //conRecordsWrapper = new List<SearchConWrapper>();
        name = '';
        chosenSize = 5;
        selectRecord();
        selectPageSize();
        fillWrapper();
        
        
    }
    
    public ApexPages.StandardSetController setCon {
        get {
            
            if(setCon == null) {                
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT AccountId, Email, Phone, Name FROM Contact]));
                
                setCon.setPageSize(chosenSize);  
                noOfRecords = setCon.getResultSize();
            }            
            return setCon;
        }
        set;
    }
    
    public void searchRecord(){
        String fname = '%'+ name + '%';
        setCon = null;              
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
            [SELECT AccountId, Email, Phone, Name FROM Contact WHERE Name Like : fname]));
        refreshPageSize();
    }
    
    
    //Changes the size of pagination
    public PageReference refreshPageSize() {
        setCon.setPageSize(chosenSize);
        fillwrapper();
        return null;
    }
    
    public List<SelectOption> selectRecord(){
        options.add(new SelectOption('ValueNone','--None--'));
        options.add(new SelectOption('Pending','Pending'));
        options.add(new SelectOption('Accepted','Accepted'));
        options.add(new SelectOption('Rejected','Rejected'));
        return options;
    }
    
    public List<SelectOption> selectPageSize(){
        pageSize.add(new SelectOption('5','5'));
        pageSize.add(new SelectOption('10','10'));
        pageSize.add(new SelectOption('15','15'));
        pageSize.add(new SelectOption('25','25'));
        return pageSize;
    }
    
    
    public List<Contact> getcontacts(){
        return (List<Contact>) setCon.getRecords();
           } 
    
    public void fillwrapper(){
        Integer i = 1;
        conRecordsWrapper = new List<SearchConWrapper>();
        system.debug('--> entered');
        For(Contact srcRec : (List<Contact>) setCon.getRecords()){
             system.debug('processed');
            SearchConWrapper srchConRecord = new SearchConWrapper();
            srchConRecord.searchConRec = srcRec;
          //  srchConRecord.sno = i; 
            if(chosenValue != null){
                if(srchConRecord.checktick == true){
                    
                }
            }
            conRecordsWrapper.add(srchConRecord); 
            i++;
        }
    } 
    
    public class SearchConWrapper{
        public Contact searchConRec{get;set;}
        public Boolean checktick{get;set;}
    }
}