public class AccountChildContactTreeGridLwc {

@AuraEnabled(cacheable=true)
public static List<Account> getAccountData(){
return [SELECT Name, Industry, (SELECT FirstName, LastName FROM Contacts) FROM Account];
}
}