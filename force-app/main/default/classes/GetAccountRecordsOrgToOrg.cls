//Bhavika's org
@RestResource(urlMapping='/getAccountInfo/*')
global class GetAccountRecordsOrgToOrg{

	@HttpGet
    global static Account getAccount(){
        System.debug('enter a block');
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String urlId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        system.debug('urlId'+urlId);
        Account accRecord = [SELECT Id, Name FROM Account WHERE Id =: urlId]; 
        return accRecord;
    }    
}