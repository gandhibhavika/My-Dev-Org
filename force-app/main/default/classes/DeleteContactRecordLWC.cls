public class DeleteContactRecordLWC {

@AuraEnabled()
public static void deleteSelectedContactRecord(String accId){
    DELETE [SELECT Id FROM Contact WHERE AccountId =: accId];
}
}