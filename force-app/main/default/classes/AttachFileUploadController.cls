public class AttachFileUploadController {
  public Attachment uploadatt{get;set;}
    
    public AttachFileUploadController(){
        
        String cid  = ApexPages.currentPage().getParameters().get('cid');
      //  system.debug('cid'+cid);
        uploadatt = new Attachment();
        uploadatt.ParentId = cid;
          
    }
    public PageReference insertAttachment(){
        upsert uploadatt;
        PageReference pg= new PageReference('/Apex/Attach_File');
        return pg;
    }
}