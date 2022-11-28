public class getStudentDetailLwc {

@AuraEnabled(cacheable = true)
public static List<Student__c> getStudentRecords(String sCity){
return [SELECT Id, Name FROM Student__c WHERE city__c =: sCity];
} 

@AuraEnabled(cacheable=true)
public static Student__c getStudentDetailById(String stdId){
return [SELECT Id, Name, City__c, Email__c, Image_Url__c FROM Student__c WHERE Id =: stdId];
}
}