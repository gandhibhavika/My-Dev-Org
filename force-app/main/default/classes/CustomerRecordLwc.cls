public class CustomerRecordLwc {
@AuraEnabled(cacheable=true)
    public  static List<customer> getcustomerRecords(){
         return [SELECT Name, All_Cities__c, email__c, State__c FROM Customer];
    }
}