public class CountryListLwc {

@AuraEnabled(cacheable=true)
public static List<Country__c> getCountryRecords(){
    return [SELECT Id, Name, Capital__c, Population__c, President__c 
            FROM Country__c];

}

@AuraEnabled(cacheable=true)
public static List<contentVersion> getContentVersion(List<String> cId){
    List<ContentDocumentLink> cdLinks = [SELECT Id, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink where LinkedEntityId In : cId ];
    Set<String> cDocIds = new Set<String>();
    for(ContentDocumentLink cdLink : cdLinks){
        if(cdLink.ContentDocumentId != null){
        cDocIds.add(cdLink.ContentDocumentId);
        }
    }
return [SELECT Id, ContentDocumentId FROM contentVersion WHERE ContentDocumentId In : cDocIds];
}
}