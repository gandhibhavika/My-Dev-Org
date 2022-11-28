public class BookingEditDetailController {
    
    public LIST<Booking__c> bookingRecord{get;set;}
    public LIST<Booking__c> inputRecord{get;set;}
    String sid;
    
    public BookingEditDetailController(){
        sid = ApexPages.currentPage().getParameters().get('id');
        // bookingRecord = new LIST<Booking__c>();
        // inputRecord = new LIST<Booking__c>();
        If(String.isNotBlank(sid)){
            inputRecord = [SELECT Id, Customer__c, Name, Status__c, Check_in__c, Check_Out_Time__c, Room__c
                           FROM Booking__c WHERE Id =: sid];
        }
       else{
            bookingRecord = [SELECT Id, Customer__c, Name, Status__c, Check_in__c, Check_Out_Time__c, Room__c 
                             FROM Booking__c LIMIT 5]; 
       }
    }
    public void saveNewRecord(){
        UPSERT inputRecord;
    }
}