public class AccountParentLwcController {

@AuraEnabled(cacheable=true)
public static List<Account> accountRecord(Id accId){
    return [SELECT Id, Name, Phone FROM Account WHERE Id =: accId];
}
}