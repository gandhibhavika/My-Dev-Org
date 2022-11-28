public class BookingListController {
    
    public List<Booking__c> bookingRecord{get;set;}
    
    public Booking__c  newBooking{get;set;}
    public Booking__c  newBooking2{get;set;}
    public Booking__c  newBooking3{get;set;} 
    
    public BookingListController(){
        bookingRecord = new List<Booking__c>();
        
        newBooking = new Booking__c();
        newBooking2 = new Booking__c();
        newBooking3 = new Booking__c();
        
        
    }
    public void saving(){
        
        bookingRecord.add(newBooking);
        bookingRecord.add(newBooking2);
        bookingRecord.add(newBooking3);
        
        INSERT bookingRecord;
        
    }
}