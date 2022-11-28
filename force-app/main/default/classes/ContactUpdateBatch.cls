global class ContactUpdateBatch implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, LastName, AccountId, Account.Type, Birthdate FROM Contact]);
    }
    
    global void execute(Database.BatchableContext bc, List<Contact> contactRecords){ 
        List<Contact> conRecords = new List<Contact>();
        For(Contact conRecord : contactRecords){       
            conRecord.Birthdate = system.today().addMonths(6);
            If(conRecord.AccountId != null){
                conRecord.Account.Type = 'Prospect';
            } 
            conRecords.add(conRecord);
        }
        if(conRecords.size()>0){
            UPDATE conRecords;
        }
    }
    
    global void finish(Database.BatchableContext bc){
        system.debug('Success');
    }
}