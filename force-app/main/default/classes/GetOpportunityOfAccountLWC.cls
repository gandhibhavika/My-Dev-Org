public class GetOpportunityOfAccountLWC {

@AuraEnabled(cacheable=true)
public static List<Opportunity> getRelatedOpportunityRecord(String recordId){
return [SELECT Id, Name, CloseDate, StageName, Amount, AccountId FROM Opportunity WHERE AccountId =: recordId];
}

}