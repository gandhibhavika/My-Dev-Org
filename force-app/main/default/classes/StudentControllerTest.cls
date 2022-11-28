@isTest
public class StudentControllerTest {
    
    @testSetup
    public static void data(){
    }
    
    @isTest public static void callSaveRecord(){
        Student_controller stuObj = new Student_controller();
        stuObj.saveRecord();
        stuObj.addStudent();
        stuObj.deleteRecord();
    }
    
}