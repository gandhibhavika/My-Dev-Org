//Bhavika's org
//Source Org
public class CalculateDistanceOrgToOrg {
    
    @AuraEnabled
    public static String getCalculatedDistance(String city1, String city2)
    {   
        Http h = new Http();        
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:calculateDistanceNamedCredential'+'/services/apexrest/city1/'+city1+'/city2/'+city2);
        request.setHeader('Content-Type','application/json');
         //request.setHeader('Authorization', 'Bearer '+System.UserInfo.getSessionId().SubString(15));
        request.setHeader('accept','application/json');
        request.setMethod('GET');
        HttpResponse response = h.send(request);
        return response.getBody();
    }
}