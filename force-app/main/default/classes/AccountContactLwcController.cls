public with sharing class AccountContactLwcController {
@auraEnabled(cacheable=true)
public static List<Account> fetchAccount()
{
    List<Account> accList=[SELECT Id,Name, (SELECT Name FROM Contacts) FROM Account LIMIT 10000];
    return accList;
}

}