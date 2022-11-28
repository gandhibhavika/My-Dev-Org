trigger projectTrigger on Project__c (after insert) {
    
    If(trigger.isAfter && trigger.isInsert){
        ProjectTriggerHelper.afterInsert(trigger.new);
    }
}