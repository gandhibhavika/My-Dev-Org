public class CreateAccountRecordLwc {

@AuraEnabled
public static void createAccRecord(Account accountObj){
    
    INSERT accountObj;
}
}