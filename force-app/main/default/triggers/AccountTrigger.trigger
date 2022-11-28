trigger AccountTrigger on Account (after update) {
    
    If(trigger.isAfter && trigger.isUpdate){
        AccountTriggerHelperClass.onUpdatingAccount(trigger.new , trigger.oldMap);
     }
    
}