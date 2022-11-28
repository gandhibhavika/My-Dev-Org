public class ContactHelperClass {
    
    public static void afterInsert(List<Contact> conRecords){
        phoneInAccCon(conRecords);
        //emailInAccCon(conRecords);
        contactsOfSameName(conRecords);
        
    }
    
    public static void beforeInsertOrUpdate(List<Contact> conRecords){
        //errorOnBirthdate(conRecords);
        
    }
    
    
    public static void phoneInAccCon(List<Contact> conRecords){
        //Way 1
        List<Account>updatedAccRecords = new List<Account>();
        Map<ID,String> conRecordMap = new Map<ID,String>();
        
        For(Contact conRecord : conRecords){
            If(conRecord.AccountId != null){
                conRecordMap.put(conRecord.AccountId , conRecord.Phone);
            }
        }
        If(conRecordMap.keyset().size()>0){
            For(String accId: conRecordMap.keyset()){
                Account accRec = new Account();
                accRec.Id = accId;
                accRec.Phone = conRecordMap.get(accId);
                updatedAccRecords.add(accRec);
            }
            Update updatedAccRecords;
        }
        
        /*....................Way2....................
List<Account>updatedAccRecords = new List<Account>();
Map<ID,String> conRecordMap = new Map<ID,String>();
For(Contact contactRecord: trigger.new){
conRecordMap.put(contactRecord.AccountId , contactRecord.Phone);
}
For(Account accountRecord: [SELECT ID, Phone FROM Account WHERE ID IN: conRecordMap.keyset()]){
accountRecord.Phone = conRecordMap.get(accountRecord.Id);
updatedAccRecords.add(accountRecord);
}
Update updatedAccRecords;


/*...................Way3......................
------Without using map(Works For single record)-----

If(trigger.isAfter && trigger.isInsert){
List<account> accPhoneList = new List<account>();
Set<String> accIds = new Set<String>();
For(Contact conRecord: trigger.new){
accPhoneList.add(new account(id= conRecord.accountId, phone = conRecord.Phone));
}
update accPhoneList;
}
*/
    }
    
    /*public static void errorOnBirthdate(List<Contact>conRecords){
        
        For(Contact conRecord: conRecords){
            If(conRecord.Birthdate == null){
                conRecord.Birthdate.addError('Enter Birthdate'); 
            }
        }
    }*/
    
    public static void emailInAccCon(List<Contact> conRecords){
        Map<Id,String> conMap = new Map<Id,String>();
        //List<String> accEmail= new List<String>();
        For(Account accRec: [SELECT Id, Email__c  FROM Account]){
            If(accRec.Email__c != null){
                conMap.put(accRec.Id, accRec.Email__c);
            }
        }
        system.debug('=='+conMap);
        For(contact conRec: conRecords){
            If(conRec.Email == conMap.get(conRec.Account.Id)){
                //conRec.AccountId = conMap.keyset(conRec.Account.Id); 
                system.debug('=='+conMap.get(conRec.Account.Id));
            }
        }
    }
    
    
    public static void contactsOfSameName(List<Contact> conRecords){
        system.debug('Entered '+conRecords);
        
        Map<Id,contact> consMap = new Map<Id,contact>();
        String NamefL;
        List<String> conName = new List<String>();
        Set<String> conAccIds = new Set<String>();
        For(Contact conRec: conRecords){
            If(conRec.AccountId != null){ 
                conAccIds.add(conRec.AccountId);
                if(conRec.FirstName!= null && conRec.LastName !=null){
                    NamefL = conRec.FirstName+' '+conRec.LastName;
                    conName.add(NamefL);
                }
            }
        }
        System.debug(conAccIds);
        List<String> conids = new List<String>();
        //List<Contact> deleteConRec = new List<Contact>();
        List<Contact> toUpdate = new List<Contact>();
        //System.debug([SELECT AccountId, FirstName,LastName,Birthdate, Phone FROM Contact WHERE AccountId IN: conAccIds AND Name IN :conAccIds]);
        For(Contact conRec: [SELECT Id, AccountId, Name, FirstName, LastName,Title ,Birthdate, Email, Phone FROM Contact
                             WHERE AccountId IN: conAccIds AND Name IN :conName]){
                                 system.debug('current rec '+conRec);
                                 if(consMap.containskey(conRec.AccountId) && conRec.Name == consMap.get(conRec.AccountId).Name){
                                     conids.add(conRec.Id);
                                     Contact contClone = conRec.clone(false,true,false,false);
                                     contClone.Id = consMap.get(conRec.AccountId).Id;
                                     consMap.put(conRec.AccountId, contClone);
                                     toUpdate.add(contClone);
                                 }
                                 else{
                                     consMap.put(conRec.AccountId, conRec);
                                 }
                             }
        If(toUpdate.size()>0){
            Update toUpdate;
        }
        system.debug('delete record '+conids);
        DELETE [select id from Contact where id In: conids ];
        
        system.debug('==>>>'+consMap);
    }
   
    public static void conEmailAccName(List<Contact> conRecords){
        
        Map<String,Account> accMap = new Map<String,Account>();
        String splittedAccEmail;
        For(Account accRec: [SELECT  Id, Name FROM Account]){
            If(accRec.Name != null){
                accMap.put(accRec.Name, accRec);
            }
        }
        String halfSplittedConEmail;
        For(Contact conRec: conRecords){
            If(conRec.Email != null){
                halfSplittedConEmail = conRec.Email.split('@').get(1).subStringBefore('.');
                system.debug(halfSplittedConEmail);
                If(accMap.containsKey(halfSplittedConEmail)){
                    conRec.AccountId = accMap.get(halfSplittedConEmail).Id;
                }
                else {
                    conRec.AccountId = null;
                }
            }
        }
    }
}