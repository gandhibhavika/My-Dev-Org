@isTest
public class AccountContactCountUsingMapTest {
    
    @testSetup public static void data(){
        Account accRec = new Account();
        accRec.Name = 'Account test';
        Insert accRec;
        
        Account accRec1 = new Account();
        accRec1.Name = 'Account test';
        Insert accRec1;
        
        Contact conRec = new Contact();
        conRec.LastName = 'Bhavika';
        conRec.Birthdate = system.today();
        conRec.AccountId = accRec.Id;
        INSERT conRec;
        
         Contact conRec2 = new Contact();
        conRec2.LastName = 'Bhavika';
        conRec2.Birthdate = system.today()+1;
        INSERT conRec2;
        
    } 
    
    @isTest public static void CallFillWrapper (){
        AccountContactCountUsingMap accObj = new AccountContactCountUsingMap();
    }
}