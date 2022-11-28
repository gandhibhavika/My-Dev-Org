public class ProjectTaskTriggerHelper {
    
    public static void afterUpdate(List<project_task__c> proTaskRecs , Map<Id,project_task__c> proTaskOldRecs){
        List<project_task__c> objList = new List<project_task__c>();
        For(Project_task__c proTaskRec : proTaskRecs){
            if(proTaskRec.completed__c == true){
                If(proTaskRec.completed__c != proTaskOldRecs.get(proTaskRec.Id).completed__c){
                    objList.add(proTaskRec);
                }
            }
        }
        if(objList.size() > 0)
            completedProjectTask(objList);
    }
    
    public static void  completedProjectTask(List<project_task__c> proTaskRecs){
        Set<String> ids = new Set<String>();
        List<Project__c> updatedStatus = new List<Project__c>();      
        for(Project_task__c proTaskRec : proTaskRecs){
            if(proTaskRec.completed__c == true && proTaskRec.Projects__c != null){
                Project__c proRc = new Project__c();
                proRc.Id = proTaskRec.Projects__c;
                
                if(proTaskRec.Type__c  == 'New Task'){
                    proRc.Status__c = 'New';
                    system.debug('New Status');
                }
                if(proTaskRec.Type__c == 'Planning Phase'){
                    proRc.Status__c = 'Planning';
                    system.debug('Planning Phase');
                }
                if(proTaskRec.Type__c == 'Construction Work'){
                    proRc.Status__c = 'Construction';
                    system.debug('Construction Work');
                }
                if(proTaskRec.Type__c == 'Completion Step'){
                    proRc.Status__c = 'Deployment';
                    system.debug('Completion Step');
                }
                if(proTaskRec.Type__c == 'Contract End'){
                    proRc.Status__c = 'Signoff';
                    system.debug('Contract End');
                }
                updatedStatus.add(proRc);
                system.debug('list of updated '+updatedStatus);
            }
            
        }
        if(updatedStatus.size() > 0){
            UPDATE updatedStatus;
        }
    }
}