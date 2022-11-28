@RestResource(urlMapping='/bulkInsertAccountRecord/*')
global class InsertMultipleAccountContactUsingRestApi {
    @HttpPost
    global Static string createAccountRecords(){
        List <Account> accList = new List < Account>();
       List < contact> conList = new List < Contact>();
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        String jsonString = req.requestBody.toString();
        boolean successCheck;
        List<ResponseWrapper> rcrdRes = (List<ResponseWrapper>) Json.deserialize(req.requestBody.toString(), List<ResponseWrapper>.class);        
        Integer index = 0;
        for(ResponseWrapper wResp: rcrdRes){
            Account accObj=new Account();
            accObj.Name=wResp.Name;
            accObj.Type=wResp.type;
            accObj.Phone=wResp.phone;
            accObj.Industry=wResp.Industry;  
			accList.add(accObj);
            
            if(wResp.contacts != null){
                For(contacts conRecs : wResp.contacts){
                    Contact con = new Contact();
                    con.OtherCity = index + '';
                    con.LastName= conRecs.name;
                    con.phone =conRecs.phone;
                    conList.add(con);
                }
            }
            index ++;
            
        } 
        try{
            
           if(accList.size() > 0 ){
               Insert accList;
               for(Contact con : conList ){
                  con.AccountId = accList.get(Integer.valueOf(con.OtherCity)).Id;
                   con.OtherCity = null;
               }
              
               Insert conList;
                successCheck=true;
            }
        }
        catch(Exception e){
            System.debug('errorMsg' + e);
            successCheck=false;
        }        
        
        if(successCheck){
            return 'Success';
        }
        else{
            return 'Failure';
        }
    }
    
    
    public class ResponseWrapper{
        public string Name;
        public string Description;
        public string Type;
        public string Phone;
        public string Industry;
        public List<contacts>contacts;
    }
    public class contacts{
        public String name;
        public String phone;
        
    }
}

/*List<responseWrapper> wRespList=(List<responseWrapper>) JSON.deserialize(jsonString,List<responseWrapper>.class);
Account obj=new Account();
List<Account> accList= new List<Account>();
for(responseWrapper wResp: wRespList){
obj.Name=wResp.Name;
obj.Type=wResp.type;
obj.Type=wResp.phone;
obj.Industry=wResp.Industry;
accList.add(obj);
}*/
/*try{
if(accList.size() > 0){
Insert accList;
successCheck=true;
}
}
catch(Exception e){
successCheck=false;
}
if(successCheck)
return 'Success';
else
return 'Failure';
}*/