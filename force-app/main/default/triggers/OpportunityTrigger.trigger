trigger OpportunityTrigger on Opportunity (before insert, before update) {
    
    If(trigger.isbefore){
        if(trigger.isInsert){
            OpportunityTriggerHelper.opportunityPicklist(trigger.new);
            OpportunityTriggerHelper.oppUniquePicklist(trigger.new);
        }
        If(trigger.isUpdate){
             OpportunityTriggerHelper.opportunityPicklist(trigger.new);
            OpportunityTriggerHelper.beforeInsertOrUpdate(trigger.new , trigger.oldMap);
        }
    }
}