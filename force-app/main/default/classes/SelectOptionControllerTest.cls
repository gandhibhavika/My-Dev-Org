@isTest
public class SelectOptionControllerTest {
    
    @testSetup
    public static void data(){
        Account accRec = new Account();
        accRec.Name = 'Test';
        INSERT accRec;
        
        Contact conRec = new Contact();
        conRec.FirstName = 'Apex';
        conRec.lastName = 'Test';
        conRec.Birthdate = system.today();
        INSERT conRec;
        
        Opportunity oppRec = new Opportunity();
        oppRec.Name = 'Test';
        oppRec.StageName = 'Need Analysis';
        oppRec.CloseDate = System.today();
        INSERT oppRec;
        
        Attachment attachObj = new Attachment();
        attachObj.parentId = accRec.Id;
        attachObj.ContentType = 'Text/plain';
        attachObj.Name = 'Attachmemnt';
        attachObj.Body = blob.valueOf('test');
        INSERT attachObj;
        
        Attachment attachObjCon = new Attachment();
        attachObjCon.parentId = conRec.Id;
        attachObjCon.ContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        attachObjCon.Name = 'AttachmemntAccount';
        attachObjCon.Body = blob.valueOf('testRun');
        INSERT attachObjCon;
        
        Attachment attachObjOpp = new Attachment();
        attachObjOpp.parentId = oppRec.Id;
        attachObjOpp.ContentType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
        attachObjOpp.Name = 'AttachmemntAccount';
        attachObjOpp.Body = blob.valueOf('testRun');
        INSERT attachObjOpp;
    }
    
    @isTest public static void callSelectOptionController(){
        SelectOptionController obj = new SelectOptionController();
        obj.chosenValue = 'ValueAccount';
        obj.callObject();
        obj.chosenValue = '--None--';
        obj.callObject();
        obj.chosenValue = 'ValueContact';
        obj.callObject();
        obj.chosenValue = 'ValueOpportunity';
        obj.callObject();
        obj.selectAllRecords();
        obj.mainCheckbox = true;
        obj.selectAllRecords();
        obj.syncAttCheckboxes();
        obj.selectAllRecforDBox();
        obj.syncRecordCbox();
        obj.popupchosenValue = 'ValueContact';
        obj.fillWrapper();
        obj.popupchosenValue = 'ValueAccount';
        obj.fillWrapper();
        obj.popupchosenValue = 'ValueOpportunity';
        obj.fillWrapper();
        obj.showPopup();
        obj.closePopup();
         // obj.RecordsWrapper
         // RecordsWrapper recWrap = new RecordsWrapper();
         // recWrap.checktick = true;
        obj.copyAttachment();
        
    }
}