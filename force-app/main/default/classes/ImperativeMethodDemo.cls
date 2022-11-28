public class ImperativeMethodDemo {

@AuraEnabled
public static void getAccountPhone(Account sName){

insert sName;
//  List<Account> accRecords = [SELECT Phone FROM Account WHERE Name =: sName];
// return accRecords;
}
}