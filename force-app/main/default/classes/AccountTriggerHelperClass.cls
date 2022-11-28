public class AccountTriggerHelperClass {
    
    public static void onUpdatingAccount(List<Account> accRecords , Map<Id,Account> accOldMap){
        Set<String> accountIds = new Set<String>();
        for(Account accRecord: accRecords){
            If(accRecord.Account_Type__c != accOldMap.get(accRecord.Id).Account_Type__c){
                accountIds.add(accRecord.Id);
            }
        }
        If(accountIds.size()>0){
            List<Opportunity> updatedOppRecords = new List<Opportunity>();
            For(Opportunity oppRecord: [SELECT Stage_Type__c, Account.Account_Type__c FROM Opportunity WHERE AccountId IN: accountIds]){
                
                If(oppRecord.Account.Account_Type__c == null || oppRecord.Account.Account_Type__c == '' ){
                    oppRecord.Stage_Type__c = '0';
                }
                else If(oppRecord.Account.Account_Type__c == 'Reseller'){
                    oppRecord.Stage_Type__c = '10';
                }
                else If(oppRecord.Account.Account_Type__c == 'Buyer'){
                    oppRecord.Stage_Type__c = '25';
                }
                else If(oppRecord.Account.Account_Type__c == 'Current Customer'){
                    oppRecord.Stage_Type__c = '100';
                }
                updatedOppRecords.add(oppRecord);
            }   
            if(updatedOppRecords.size()>0){
                UPDATE updatedOppRecords;
            }
        }
    }
}