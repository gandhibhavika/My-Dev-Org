public class PopupPage{
    public Boolean displayPopup{get;set;} 
    public PopupPage(){
    }
    
    public void showPopup(){
        displayPopup = true;
    }
     public void closePopup(){
       displayPopup = false;
    }
    
    
}