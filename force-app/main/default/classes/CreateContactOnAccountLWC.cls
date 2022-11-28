public class CreateContactOnAccountLWC {

@AuraEnabled(cacheable=true)
public static Account getAccountName(String accId){
    return [SELECT Name FROM Account WHERE Id =: accId];
}

@AuraEnabled
public static void saveContactRecord(Contact contactObj){
        System.debug('contactObj--'+contactObj);
        try{
            insert contactObj;
        }
        catch(Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}