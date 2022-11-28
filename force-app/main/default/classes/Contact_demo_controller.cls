public class Contact_demo_controller {
    
  //declaration
    public List<Contact> conRecord{get;set;}
    
    public Contact_demo_controller(){
      //initialization
        conRecord = new List<Contact>();
        conRecord = [SELECT lastName, Phone FROM Contact WHERE AccountId != null];
        system.debug(conRecord);
    }
}



//queries
//queries store into list