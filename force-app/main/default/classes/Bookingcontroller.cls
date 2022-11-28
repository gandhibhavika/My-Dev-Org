public class Bookingcontroller {
    public Booking__c  newBooking{get;set;}
    public Booking__c  newBooking2{get;set;}
    public Booking__c  newBooking3{get;set;}
    
    public Bookingcontroller(){
        newBooking = new Booking__c();
		newBooking2 = new Booking__c();
        newBooking3 = new Booking__c();
        
    }
    public void saveRecord(){
        INSERT  newBooking;
        INSERT  newBooking2;
        INSERT  newBooking3;
        newBooking = new Booking__c(); 
		newBooking2 = new Booking__c();
        newBooking3 = new Booking__c();
        
        
    }
    
    
}