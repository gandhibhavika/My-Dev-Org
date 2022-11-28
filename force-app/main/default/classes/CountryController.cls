public class CountryController {
    public Map<String,Set<String>> nmap{get;set;}
    public String stateRecords{get;set;}
    public List<selectOption> countryName{get;set;}
    public List<selectOption> stateName{get;set;}
    public List<selectOption> cityName{get;set;}
    public String selectedCountry{get;set;}
    public String selectedState{get;set;}
    public Map<String,Set<String>> cityMap{get;set;}
    
    public CountryController(){
        nMap = new Map<String,Set<String>>();
        cityMap = new Map<String,Set<String>>();
        selectedListCountry();
    }
    
    public void selectedListCountry(){
        countryName = new List<selectOption>();
        countryName.add(new SelectOption('None','None'));
        For(Country__c cntryRecord : [Select Name, State__c, City__c From Country__c]){
            set<String> states = nmap.get(cntryRecord.Name);
            set<String> cities = cityMap.get(cntryRecord.State__c);
            if(states == null){
                states = new set<String>();
            }
            If(cities == null){
                cities = new set<String>();
            }
            states.add(cntryRecord.State__c);
            cities.add(cntryRecord.City__c);
            nmap.put(cntryRecord.Name, states);
            cityMap.put(cntryRecord.State__c, cities);
        }
        System.debug('##nmap@'+nmap);
        System.debug('##@#########'+cityMap);
        
        for(String key: nmap.keySet()){
            countryName.add(new SelectOption(key,key));
        }
    }
    public void selectedListState(){
        cityName = new List<selectOption>();
        cityName.add(new SelectOption('None','None'));
        stateName = new List<selectOption>();
        stateName.add(new SelectOption('None','None'));
        If(nmap.containsKey(selectedCountry)){
            for(String state : nmap.get(selectedCountry)){
                stateName.add(new SelectOption(state , state));
            }
        }    
    }
    
    public void selectedListCity(){
        system.debug('method called');
        cityName = new List<selectOption>();
        cityName.add(new SelectOption('None','None'));
        If(citymap.containsKey(selectedState)) {
            for(String cityrec : cityMap.get(selectedState)) {
                cityName.add(new SelectOption(cityrec , cityrec));
            }
        }    
    }
}