trigger CaseTrigger on Case (after update){
    
    if(trigger.isAfter && trigger.IsUpdate){
        caseTriggerHelper.caseValidation(trigger.new, trigger.oldMap);
    }
}