@isTest
public class BookingControllerTest {
    
    @testSetup static void data(){
        Individual indvRec = new Individual();
        indvRec.LastName = 'Dikshit';
        INSERT indvRec;
        Customer custRec = new Customer();
        custRec.PartyId = [select id from Individual limit 1].Id;
        custRec.State__c = 'Rajasthan';
        custRec.Name = 'Bhavika';
        INSERT custRec;
    }
    
    @isTest public static void callsaveRecord(){
        Bookingcontroller bookingobj = new Bookingcontroller();
        
        bookingobj.newBooking = new Booking__c(Customer__c = [select id from Customer limit 1].Id);
        bookingobj.newBooking2 = new Booking__c(Customer__c = [select id from Customer limit 1].Id);
        bookingobj.newBooking3 = new Booking__c(Customer__c = [select id from Customer limit 1].Id);
        bookingobj.saveRecord();
    }
}