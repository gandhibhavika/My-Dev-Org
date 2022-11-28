public class HireFormTriggerHelper {
    
    public static void beforeInsert(List<Hire_form__c> hFrecords){
        List<Contact> contactRecords = new List<Contact>();
        For(Hire_Form__c hfRecord : hFrecords){
            hfRecord.Status__c = 'In Progress';
            Contact conRecord = new Contact();
            conRecord.FirstName = hfRecord.First_Name__c;
            conRecord.Birthdate = System.today();
            conRecord.LastName = hfRecord.Last_Name__c;
            conRecord.Email = hfRecord.Email__c;
            conRecord.Phone = hfRecord.Phone__c;
            contactRecords.add(conRecord);
        }
        INSERT contactRecords;
        List<case> caseRecords = new List<case>();
        if(contactRecords.size() > 0){
            For(Contact conRec : contactRecords){
                Case caseRec = new Case();
                caseRec.ContactId = conRec.Id;
                caseRec.Status = 'New';
                caseRecords.add(caseRec);
            }
            if(caseRecords.size() > 0){
                INSERT caseRecords;
            }
        }
        For(Integer i = 0; i < hFrecords.size(); i++){
            hFrecords[i].Candidate__c = contactRecords[i].Id;
        }   
    }
    
    public static void afterUpdate(List<Hire_form__c> hFrecords){
        List<Case> caseUpdtdRecords = new List<Case>();
        Set<String> completedRecords = new set<string>();
        For(Hire_Form__c hfRecord : hFrecords){
            If(hfRecord.Status__c == 'Completed'){
                completedRecords.add(hfRecord.Candidate__c);
            }
        }
        List<Case> cons = [SELECT Id, Status FROM Case WHERE ContactId IN : completedRecords];
        For(Case caseRec : cons){
            caseRec.Status = 'Closed';
            caseUpdtdRecords.add(caseRec);
        }
        if(caseUpdtdRecords.size() > 0){
            UPDATE caseUpdtdRecords;
        }
    }
}