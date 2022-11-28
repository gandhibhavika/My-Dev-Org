trigger projectTaskTrigger on Project_Task__c (after Update) {
    
    If(trigger.isafter && trigger.isUpdate){
      ProjectTaskTriggerHelper.afterUpdate(trigger.new , trigger.oldMap);
        
    }
}