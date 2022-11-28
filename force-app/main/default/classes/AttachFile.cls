public class AttachFile {
    public List<ContactWrapper> contactWrapper{get;set;}
    public Attachment attachmentRecords{get;set;}
    public String cid{get;set;}
    Map<String,Blob> mapName{get;set;}
    
    public AttachFile(){
        contactWrapper = new List<ContactWrapper>();
        mapName = new Map<String,Blob>();
        fillWrapper();
    }
    
    public void fillWrapper(){
        
        Integer index = 1;
        List<Contact> contactRecords = [SELECT Id, (SELECT Id FROM Attachments),
                                        Name, Phone, LeadSource, Email FROM Contact];        
        for(Contact contactRecord : contactRecords){
            ContactWrapper conWrapper = new ContactWrapper();
            conWrapper.sNo = index;
            conWrapper.Name = contactRecord.Name;
            conWrapper.Phone = contactRecord.Phone;
            conWrapper.LeadSource = contactRecord.LeadSource;
            conWrapper.Email = contactRecord.Email;
            conWrapper.Id = contactRecord.Id;
            index++;
            
            If(contactRecord.Attachments != null && contactRecord.Attachments.size() > 0){
                conWrapper.attid = contactRecord.Attachments[0].Id;
            }
            contactWrapper.add(conWrapper);  
        } 
    }
    
    public void deleteRecord(){
        
        Delete [Select Id From Attachment WHERE id =: cid];
        system.debug('cid- '+cid);
        
    }
    
    
    public class ContactWrapper{
        public String Id{get;set;}
        public Integer sNo{get;set;}
        public String Phone{get;set;}
        public String Name{get;set;}
        public String LeadSource{get;set;}
        public String Email{get;set;}
        public Blob body{get;set;}
        public String attid{get;set;}
    }
}