//Unique Name
trigger CourseTrigger on Course__c (before insert, before update) {
    
    If(trigger.isBefore && trigger.isInsert ){
        Set<String> alreadyExistingRecord = new Set<String>();
        For(Course__c crseRec: [SELECT Name FROM Course__c]){
            alreadyExistingRecord.add(crseRec.Name.toLowerCase());
        }
        For(Course__c courseRecord: trigger.new){
            If(courseRecord.Name.toLowerCase()!=null){
                If(alreadyExistingRecord.contains(courseRecord.Name.toLowerCase())){
                    courseRecord.Name.addError('Duplicate names are not allowed.');
                } 
            }
        }
    }
}