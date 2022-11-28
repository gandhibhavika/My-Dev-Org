public class CountryCapitalLwc {

@AuraEnabled(cacheable=true)
public static List<Country__c> getCountryName(){
return [SELECT Name FROM Country__c ];
}


@AuraEnabled(cacheable=true)
public static Country__c getCountryRecords(String cName){
    return [SELECT Id, Name, (SELECT Id FROM Attachments), Capital__c, Population__c, President__c FROM Country__c WHERE Name =: cName LIMIT 1];
}

@AuraEnabled(cacheable=true)
public static contentVersion getContentVersion(String cId){
    ContentDocumentLink cdLink = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink where LinkedEntityId  =: cId LIMIT 1];
return [SELECT Id, ContentDocumentId FROM contentVersion WHERE ContentDocumentId =: cdLink.ContentDocumentId LIMIT 1];
}
}