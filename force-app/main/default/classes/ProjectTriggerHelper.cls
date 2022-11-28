public class ProjectTriggerHelper {
    
    public static void afterInsert(List<project__c> projectRecords){
        List<Project_Task__c> proTaskRecs = new List<Project_Task__c>();
        List<String> proTaskStatus = new  List<String>{'New Task' , 'Planning Phase' ,'Construction Work' , 'Completion Step' ,'Contract End'};
            For(Project__c proRec: projectRecords){
                For(integer i=0 ; i<5; i++){
                    Project_Task__c proTaskRec = new Project_task__c();
                    proTaskRec.Projects__c = proRec.Id;
                    proTaskRec.Type__c = proTaskStatus[i];
                    proTaskRecs.add(proTaskRec);
                }
            }
        if(proTaskRecs.size() > 0){
            INSERT proTaskRecs;
        }
        For(Integer i=0; i<4; i++){
            proTaskRecs[i+1].Previous_Task__c =  proTaskRecs[i].Id;
        }
        if(proTaskRecs.size() > 0){
            UPDATE proTaskRecs;
        }
        system.debug('List' +proTaskRecs);
    }
}