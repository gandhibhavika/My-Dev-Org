public with sharing class ContactRecord {
    
@auraEnabled(cacheable = true)
public static list<Contact> showContact(){
List<Contact> conRecords = new List<Contact>();
conRecords = [SELECT Id, Name, Phone, Email FROM Contact];
return conRecords;
}
}