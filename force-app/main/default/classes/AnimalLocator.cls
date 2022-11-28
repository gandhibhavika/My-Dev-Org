public class AnimalLocator {
    
    public static String getAnimalNameById(Integer value){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(' https://th-apex-http-callout.herokuapp.com/animals/'+value);
        request.setMethod('GET');
        request.setBody('{"name":"mighty moose"}');
        HttpResponse response = http.send(request);
         if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> animals = (List<Object>) results.get('animals');
            System.debug('Received the following animals:');
            for(Object animal: animals) {
                System.debug(animal);
            }
             system.debug(response.getBody());
        }
        return response.getBody();
    }
}