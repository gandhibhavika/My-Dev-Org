public class Student_controller {
    
    public List <Student__c> studentRecord{get;set;}
    
    public Student_controller() {
        studentRecord = new LIST<Student__c>();
        studentRecord = [SELECT Name, Class__c, email__c, DOB__c FROM Student__c LIMIT 10];
    }
   
    public void saveRecord(){
        UPSERT studentRecord; 
    }
    
    public void addStudent(){
        studentRecord.add(new Student__c());
    }
    
    public void deleteRecord(){
        studentRecord.remove(studentRecord.size()-1);
    }
}