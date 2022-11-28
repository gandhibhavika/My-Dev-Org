public class BookingControllerEditAndDetail {
    public LIST <Booking__c> bookingRecord{get;set;}
    public LIST <Booking__c> inputRecord{get;set;}
    
    public BookingControllerEditAndDetail(){
        
        bookingRecord = new LIST <Booking__c>();
        inputRecord = new LIST <Booking__c>(); 
        
        inputRecord = [SELECT Customer__c, Name, Status__c, Check_in__c, Check_Out_Time__c, Room__c, Total_Hours__c FROM Booking__c ];
        
        bookingRecord =[SELECT Customer__c, Name, Status__c, Check_in__c, Check_Out_Time__c, Room__c, Total_Hours__c FROM Booking__c LIMIT 5];
        
    }
    
    public void saveRecord(){
        INSERT inputRecord;
        
    }
    
}