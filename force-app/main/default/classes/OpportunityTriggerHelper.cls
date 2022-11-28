public class OpportunityTriggerHelper {
    
    //Assignment 1
    public Static void opportunityPicklist(List<Opportunity> opportunityRecords){
        set<String> accountIds = new set<String>();
        For(Opportunity oppRecord: opportunityRecords){
            If(oppRecord.AccountId != null){
                accountIds.add(oppRecord.AccountId);
            }
        } 
        
        Map<String, Account> accountMap = new Map<String, Account>([SELECT Id, Account_Type__c From Account
                                                                    WHERE Id IN : accountIds]);
        For(Opportunity oppRecord: opportunityRecords){
            If(oppRecord.AccountId != null){
                Account accRecord = accountMap.get(oppRecord.AccountId);
                If(accRecord.Account_Type__c == null || accRecord.Account_Type__c == ''	){
                    oppRecord.Stage_Type__c	= '0';
                }
                else If(accRecord.Account_Type__c == 'Reseller'){
                    oppRecord.Stage_Type__c	= '10';
                }
                else If(accRecord.Account_Type__c == 'Buyer'){
                    oppRecord.Stage_Type__c	= '25';
                }
                else If(accRecord.Account_Type__c == 'Current Customer'){
                    oppRecord.Stage_Type__c	= '100';
                }
            }
        }
    }
    
    //Assignment 7
    public static void beforeInsertOrUpdate(List<Opportunity> opportunityRecords , Map<Id,Opportunity> oppRecordsOldMap){
          For(Opportunity oppRecord : opportunityRecords){
                If(oppRecord.StageName != oppRecordsOldMap.get(oppRecord.Id).StageName || 
                   oppRecord.AccountId != oppRecordsOldMap.get(oppRecord.Id).AccountId)
                    oppUniquePicklist(opportunityRecords);
    }
    }
    
    public Static void oppUniquePicklist(List<Opportunity> opportunityRecords){
        set<Id> accIds = new set<Id>();
        map<Id,List<String>> oppStageMap = new Map<Id,List<String>>();
        for(Opportunity oppRecord : opportunityRecords){ //For duplicate values
            accIds.add(oppRecord.AccountId);
            if(oppStageMap.containsKey(oppRecord.AccountId)){
                if(oppStageMap.get(oppRecord.AccountId).contains(oppRecord.StageName)){
                    oppRecord.StageName.addError('Please choose different stage');
                }else{
                    oppStageMap.get(oppRecord.AccountId).add(oppRecord.StageName);
                }               
            }else{
                oppStageMap.put(oppRecord.AccountId , new List<String>{oppRecord.StageName});
            }
        }
        
        Map<Id,Set<String>> oppMap = new Map<Id,Set<String>>();
        List<Opportunity> oppRecords = [SELECT AccountId, StageName FROM Opportunity WHERE AccountId In : accIds];
        for(Opportunity opprec: oppRecords){
            if(oppRec.StageName!= null){
                if(oppMap.containsKey(opprec.AccountId)){
                    oppMap.get(opprec.AccountId).add(opprec.StageName);
                }else{
                    oppMap.put(opprec.AccountId,new set<String>{opprec.StageName});
                }
            }
        }
        
        for(Opportunity opprec : opportunityRecords){
            if(oppMap.containsKey(opprec.AccountId) && oppMap.get(opprec.AccountId).contains(opprec.StageName)){
                opprec.StageName.addError('Please choose different stage');
            }
        }
    }
}