public class GetContactData {

@AuraEnabled(cacheable=true)
public static List<Contact> getContact(){
List<Contact> conRecords = [SELECT Name, Phone, Email FROM Contact];
return conRecords;
}
}