public class NestedMapCountryController{
    public Map<String,Map<String,Set<String>>> nmap{get;set;}
    public String stateRecords{get;set;}
    public List<selectOption> countryName{get;set;}
    public List<selectOption> stateName{get;set;}
    public List<selectOption> cityName{get;set;}
    public String selectedCountry{get;set;}
    public String selectedState{get;set;}
    
    
    public NestedMapCountryController(){
        countryName = new List<selectOption>();
        nMap = new Map<String,Map<String,Set<String>>>();
        selectedListCountry();
    }
    
    public void selectedListCountry(){
        countryName.add(new SelectOption('None','None'));
        For(Country__c cntryRecord : [Select Name, State__c, City__c From Country__c]){
            if(nmap.containsKey(cntryRecord.Name)){
                if(nmap.get(cntryRecord.Name).containsKey(cntryRecord.State__c)){
                    nmap.get(cntryRecord.Name).get(cntryRecord.State__c).add(cntryRecord.City__c);
                }
                nmap.get(cntryRecord.Name).put(cntryRecord.State__c, new Set<String>{cntryRecord.City__c});
            }
            else{
                nmap.put(cntryRecord.Name , new Map<String,Set<String>>{cntryRecord.State__c => new Set<String>{cntryRecord.City__c}});
            }
        }
        For(String str : nmap.keyset()){
            countryName.add(new SelectOption(str , str));
        }
    }
    
    public void selectedListState(){
        stateName = new List<selectOption>();
        stateName.add(new SelectOption('None','None'));
        for(String state : nmap.get(selectedCountry).keyset()){
            stateName.add(new SelectOption(state , state));
        }
    }   
    
    
    public void selectedListCity(){
        system.debug('method called');
        cityName = new List<selectOption>();
        cityName.add(new SelectOption('None','None'));
        If(nmap.get(selectedCountry).containsKey(selectedState)) {
            for(String cityrec : nmap.get(selectedCountry).get(selectedState)) {
                cityName.add(new SelectOption(cityrec , cityrec));
            }
        }   
    }   
}