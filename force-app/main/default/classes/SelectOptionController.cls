public class SelectOptionController{
    Public List<selectOption> options{get;set;}
    Public String chosenValue{get;set;}
    Public String popupchosenValue{get;set;}
    Public List<Attachment> attRecord{get;set;} 
    public List<RecordsWrapper> wrapperRecordList{get;set;}
    public List<attWrapper> attachmentWrapper{get;set;}
    public Boolean displayPopup{get;set;} 
    public String name{get;set;}
    public List<attWrapper> copylist{get;set;}
    public List<Attachment> newlist1{get;set;}
    public Set<Id> ids{get;set;}
    public Boolean mainCheckbox{get;set;}
    public Boolean MasterCheckTick{get;set;}
    public Boolean showCopyTo{get;set;}
    public Boolean showCopyAssign{get;set;}
    public Boolean srchBtnVisible{get;set;}
    public Boolean columnVisiblity{get;set;}
    public Boolean columnVisiblityDb{get;set;}
    public Boolean onSearch{get;set;}
    
    public  SelectOptionController(){
        options = new List<selectOption>();
        wrapperRecordList = new List<RecordsWrapper>();
        attachmentWrapper = new List<attWrapper>();
        displayPopup = false;
        name = ' ';
        ids= new Set<Id>();
        showCopyTo = false;
        showCopyAssign = true;
        onSearch = false;
        
        selectRecord();
    }
    public List<selectOption> selectRecord(){
        options.add(new SelectOption('ValueNone','--None--'));
        options.add(new SelectOption('ValueAccount','Account'));
        options.add(new SelectOption('ValueContact','Contact'));
        options.add(new SelectOption('ValueOpportunity','Opportunity'));
        return options;
    }
    public void callObject(){
        ids= new Set<Id>();
        
        mainCheckbox = false;
        If(chosenValue == '--None--'){
            columnVisiblity = false;        }
        else{
            columnVisiblity = true; 
            If(chosenValue == 'ValueAccount'){
                For(Account accRecord: [SELECT Id, Name FROM Account]){
                    ids.add(accRecord.Id); 
                }
            }
            else if(chosenValue == 'ValueContact'){
                For(Contact conRecord: [SELECT Id, Name FROM Contact]){
                    ids.add(conRecord.Id);
                }
            }
            else if(chosenValue == 'ValueOpportunity'){
                For(Opportunity oppRecord: [SELECT Id, Name FROM Opportunity]){
                    ids.add(oppRecord.Id);
                }
            }
            attachmentWrapper = new List<attWrapper>(); 
            For(Attachment attRecord: [SELECT Id, Parent.Name ,Name, body, ContentType FROM Attachment 
                                       WHERE ParentId IN: ids ]){
                                           attWrapper attWrapperRecord = new attWrapper();
                                           attWrapperRecord.attrec = attRecord;
                                           attachmentWrapper.add(attWrapperRecord);
                                       }
        }
    }
    
    public void selectAllRecords(){
        system.debug('under==> '+attachmentWrapper);
        for(attWrapper attWrapRecord: attachmentWrapper){
            If(mainCheckbox == true){ 
                attWrapRecord.isSelected = true;
            }
            else{
                attWrapRecord.isSelected = false;
            }
        
            If( attWrapRecord.isSelected == true ){
                showCopyTo = true;
            }
            else If( attWrapRecord.isSelected == false){
                showCopyTo = false	;
            } 
        }
    }
    
    public void syncAttCheckboxes(){
        Integer count = 0;
        for(attWrapper attWrapRecord: attachmentWrapper){
            If(attWrapRecord.isSelected == true)
                count++;
        }
        If(attachmentWrapper.size() == count){
            mainCheckbox = true;
        }
        else{
            mainCheckbox = false;
        }
        If(count > 0){
            showCopyTo = true;
        }
        else If(count == 0 ){
            showCopyTo = false;
        }
    }
    
    public void selectAllRecforDBox(){
        system.debug('under==> '+wrapperRecordList);
        for(RecordsWrapper objectsWrapRecord: wrapperRecordList){
            If(MasterCheckTick == true){
                objectsWrapRecord.checktick = true;
            }
            else{
                objectsWrapRecord.checktick = false;
            }
        }
        If( MasterCheckTick == true){
            showCopyAssign = false;
        }
        else If( MasterCheckTick == false){
            showCopyAssign = true;
        }
        
    }
    
    public void syncRecordCbox(){
        Integer count = 0;
        for(RecordsWrapper objWrapRecord: wrapperRecordList){
            If(objWrapRecord.checktick == true)
                count++;
        }
        If(wrapperRecordList.size() == count){
            MasterCheckTick = true;
        }
        else{
            MasterCheckTick = false;
        }
        If(count > 0){
            showCopyAssign = false;
        }
        else If(count == 0){
            showCopyAssign = true;
        }
        
    }
    
    public void fillWrapper(){
        MasterCheckTick = false; 
        showCopyAssign = true;
        columnVisiblityDb  = true;
        onSearch = true;
        integer snocount=1;
        String fname = '%'+ name + '%';         
        wrapperRecordList = new List<RecordsWrapper>();
        If(popupchosenValue == 'ValueAccount'  ){
            for(Account accRecord: [SELECT Id, Name FROM Account WHERE Name Like: fname ]){
                RecordsWrapper wrapperRecord = new RecordsWrapper();
                wrapperRecord.sno = snocount;
                wrapperRecord.Name = accRecord.Name;
                wrapperRecord.prntId = accRecord.Id;
                wrapperRecord.checktick = false;
                wrapperRecordList.add(wrapperRecord);
                snocount++;
            }
        }
        else if(popupchosenValue == 'ValueContact'){
            for(Contact conRecord: [SELECT Id, Name FROM Contact WHERE Name Like: fname ]){
                RecordsWrapper wrapperRecord = new RecordsWrapper();
                wrapperRecord.sno = snocount;
                wrapperRecord.Name = conRecord.Name;
                wrapperRecord.prntId = conRecord.Id;
                wrapperRecord.checktick = false;
                wrapperRecordList.add(wrapperRecord);
                snocount++;
            }
        }
        else if(popupchosenValue == 'ValueOpportunity'){
            for(Opportunity oppRecord: [SELECT Id, Name FROM Opportunity WHERE Name Like: fname ]){
                RecordsWrapper wrapperRecord = new RecordsWrapper();
                wrapperRecord.sno = snocount;
                wrapperRecord.Name = oppRecord.Name;
                wrapperRecord.prntId = oppRecord.Id;
                wrapperRecord.checktick=false;
                wrapperRecordList.add(wrapperRecord);
                snocount++;
            }
        }    
    }
    public void showPopup(){
        displayPopup = true;
        columnVisiblity = false;
        copylist = new List<attWrapper>();
        for(attWrapper newWrapperList: attachmentWrapper){
            If(newWrapperList.isSelected == true){
                copylist.add(newWrapperList);
            }
        }
    }
    
    public void closePopup(){
        displayPopup = false;
    }
    //Way1   
    public void copyAttachment(){
        newlist1 = new List<Attachment>();
        For(RecordsWrapper recWrap: wrapperRecordList){
            If(recWrap.checktick == true){
                For(attWrapper cpy: copylist){
                    Attachment newatt = new Attachment();
                    newatt.Name = recWrap.Name;
                    newatt.body = cpy.attrec.body;
                    newatt.ParentId = recWrap.prntId;
                    newatt.ContentType = cpy.attrec.contentType;
                    newlist1.add(newatt);
                }
            }
        }
        Insert newlist1;
        closePopup(); 
    }
    
    //way2
    /* public void copyAttachment(){
newlist1 = new List<Attachment>();
For(RecordsWrapper recWrap: wrapperRecordList){

If(recWrap.checktick == true){
For(attWrapper cpy: copylist){
//newatt.Name = cpy.Name
Attachment newatt = cpy.attrec.clone(false,false,false,false);
newatt.ParentId = recWrap.prntId;
newlist1.add(newatt);
}
}
}
Insert newlist1;
}*/
    
    //Inside Dialog box
    Public class RecordsWrapper{
        public Integer sno{get;set;}
        public String Name{get;set;}
        public ID prntId{get;set;}
        public String contntType{get;set;}
        public Boolean checktick{get;set;}
        
    }
    //Main vf page UI
    public class attWrapper{
        public Boolean isSelected{get;set;}
        public Attachment attrec{get;set;}
        
    }
}