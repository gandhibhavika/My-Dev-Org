@isTest
public class TestAccDateContactTriggerHelper {
    
    @testSetup public static void data(){
        Account accRec = new Account();
        accRec.Name = 'Acc1';
        accRec.Date__c = System.today();        
        Insert accRec;
        
         Account accRec2 = new Account();
        accRec2.Name = 'Acc2';
        accRec2.Date__c = System.today();        
        Insert accRec2;
        
        Contact conRec = new Contact();
        conRec.LastName = 'Test1';
        conRec.AccountId = accRec.Id;
        conRec.Birthdate = system.today();
        Insert conRec;
        
        Contact conRec1 = new Contact();
        conRec1.LastName = 'Test2';
        conRec1.AccountId = accRec.Id;
        conRec1.Birthdate = system.today();
        Insert conRec1;
        
        Contact conRec3 = new Contact();
        conRec3.LastName = 'Test2';
        conRec3.AccountId = accRec.Id;
        conRec3.Birthdate = system.today()+1;
        Insert conRec3;
        
        Contact conRec2 = new Contact();
        conRec2.LastName = 'Test3';
        conRec2.AccountId = accRec2.Id;
        conRec2.Birthdate = system.today()+1;
        Insert conRec2;        
    }
    
    @isTest public static void CallAccDateContact(){
        AccDateContactTriggerHelper accObj = new AccDateContactTriggerHelper();
    }
}