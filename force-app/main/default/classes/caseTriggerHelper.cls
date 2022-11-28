public class caseTriggerHelper {
    
    public static void caseValidation(List<Case> csRecords, Map<id,Case>oldCaseMap){
        List<String>idsList = new List<String>();
        For(Case caseRec : csRecords){
            If(caseRec.Status != oldCaseMap.get(caseRec.Id).Status){
                if(caseRec.Status == 'Closed'){
                    idsList.add(caseRec.ContactId);
                }
            }
        }
        If(idsList.size()>0){
            List<Hire_Form__c> hfRec = [SELECT Status__c FROM Hire_Form__c WHERE Candidate__c In: idsList];
            For(Case csRec: csRecords){
                If(hfRec[0].Status__c != 'Completed'){
                    csRec.Status.addError('Hirirng status is in Progress');
                    
                } 
            }
        }
    }
}