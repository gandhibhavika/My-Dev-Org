public class AttachmentTrial {
    public List<AttWrapper> attWrapper{get;set;}
    public AttachmentTrial() {
        
        attWrapper = new List<AttWrapper>();
        attachImage();
    }
    
    public void attachImage(){
        Integer index = 1;
        For(Attachment attach : [SELECT Id, body FROM Attachment]){
            AttWrapper wrapperRecord = new AttWrapper();
            wrapperRecord.sno = index;
            wrapperRecord.Id = attach.Id;
            wrapperRecord.body = attach.body;
            attWrapper.add(wrapperRecord);
            index++;
        }
    }
    
    public class AttWrapper{
        public  Integer sno{get;set;}
        public  String Id{get;set;}
        public  Blob body{get;set;}
    }
}