/*
Assignment- 1 (Extra asgmt. by ss)
Requirement- Contact's date should be one month greater than its parent account date.
if that account already have some contact in it then 
inserted contact's month should be one greater than last contact of same parent. 
*/
public class AccDateContactTriggerHelper {
    public static void accDateContact(List<Contact> conRecords){
        system.debug('Entered in Date');
        Set<Id> accIds = new Set<Id>();
        Map<Id,Integer> countConMap = new Map<Id,Integer>();
        for(Contact conRecord : conRecords){
            accIds.add(conRecord.AccountId);
        }
        Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id, Date__c FROM Account WHERE Id In : accIds]);
        for(Contact conRec : conRecords){
            if(accMap.containsKey(conRec.AccountId) && accMap.get(conRec.AccountId).Date__c!=null){
                if(countConMap.containskey(conRec.AccountId)){
                    countConMap.put(conRec.AccountId, countConMap.get(conRec.AccountId) +1 );
                }
                else{
                    countConMap.put(conRec.AccountId, 1);
                }
                System.debug('***'+conRec.AccountId);
                conRec.Date__c = accMap.get(conRec.AccountId).Date__c.addMonths(countConMap.get(conRec.AccountId));
            }
        }
        
        Map<Id,Date> conDateMap = new Map<Id,Date>();
        for(Contact conRecord : [SELECT AccountId, Id, Date__c FROM Contact 
                                 WHERE AccountId In : accIds ORDER by Date__c ASC]){
                                     conDateMap.put(conRecord.AccountId,conRecord.Date__c);
                                 }
        for(Contact contactRecord : conRecords){
            
            if(contactRecord.AccountId != null && conDateMap.containsKey(contactRecord.AccountId) && 
               conDateMap.get(contactRecord.AccountId)!=null){
                if(countConMap.containskey(contactRecord.AccountId)){
                    countConMap.put(contactRecord.AccountId, countConMap.get(contactRecord.AccountId) +1 );
                }
                else{
                    countConMap.put(contactRecord.AccountId, 1);
                }
                contactRecord.Date__c = conDateMap.get(contactRecord.AccountId).addMonths(countConMap.get(contactRecord.AccountId));
            }        
        }
    }
    }