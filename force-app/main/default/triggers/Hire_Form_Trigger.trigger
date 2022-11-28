trigger Hire_Form_Trigger on Hire_Form__c (before insert, after update) {
    
    
    If(trigger.isBefore && trigger.isInsert){
        HireFormTriggerHelper.beforeInsert(trigger.new);
        
    }
    If(trigger.isAfter && trigger.isUpdate){
        HireFormTriggerHelper.afterUpdate(trigger.new);
    }
}