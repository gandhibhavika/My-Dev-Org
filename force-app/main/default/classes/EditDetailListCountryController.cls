public class EditDetailListCountryController {
    public Country__c countryRecord{get;set;}
    public List<Country__c> countryRecordsList;
    public List<Country__c> countryRecords;
    public List<WrapperForCountry> wrapperRecords{get;set;}
    public List<WrapperForCountry> secondWrapperRecords{get;set;}
    public boolean masterCheckBox{get;set;}
    public Boolean showEdit{get;set;}
    public Boolean showAll{get;set;}
    public String countryName;
    
    public EditDetailListCountryController(){
        showEdit = false;
        showAll = true;
        secondWrapperRecords = new List<WrapperForCountry>();
        countryRecord = new Country__c();
        wrapperRecords = new List<WrapperForCountry>();
        countryRecordsList = new List<Country__c>();
        countryRecords = new List<Country__c>();
        
        if(String.isNotBlank(countryName))
            countryRecord = [SELECT Id, Name, State__c, City__c FROM Country__c];
        countryRecordsList = new List<Country__c>();
    }
    public void saveRecords(){
        showAll = true;
        if(secondWrapperRecords != null && secondWrapperRecords.size() == 0){
            countryRecordsList = new List<Country__c>();
            countryRecordsList.add(countryRecord);
            countryRecords.add(countryRecord);        
            fillWrapperRecords();
        }
        secondWrapperRecords = new List<WrapperForCountry>();
        countryRecord = new Country__c();
        masterCheckBox = false;
        for(WrapperForCountry conwrap : secondWrapperRecords){
            conwrap.singleSelectCheckBox = false;
        }
        
    }
    public void fillWrapperRecords(){
        Integer i = countryRecordsList.size()+1;
        for(Country__c conRec : countryRecordsList){
            WrapperForCountry wrapObject = new WrapperForCountry();
            wrapObject.serialNumber = i;
            wrapObject.countryName = conRec.Name;
            wrapObject.stateName = conRec.State__c;
            wrapObject.cityName = conRec.City__c;
            wrapperRecords.add(wrapObject);
            i= i+1;
        }
    }
    public void editRecords(){
        showEdit = true;
        showAll = false;
        secondWrapperRecords = new List<WrapperForCountry>();
        System.debug('wrapperRecords'+wrapperRecords);
        System.debug('countryRecord'+countryRecord);
        for(WrapperForCountry wrapR : wrapperRecords){
            
            if(wrapR.singleSelectCheckBox == true){
                secondWrapperRecords.add(wrapR);
            }
            System.debug('%%%'+secondWrapperRecords);
            
        }
        masterCheckBox = false;
        for(WrapperForCountry wrap : secondWrapperRecords){
            wrap.singleSelectCheckBox = false;
        }
    }
    
    public void deleteALL(){
        wrapperRecords.clear();
    }
    public void deleteSelected(){
        List<WrapperForCountry> wrapperFilteredList = new List<WrapperForCountry>();
        for(WrapperForCountry wrapR : wrapperRecords){
            if(wrapR.singleSelectCheckBox != true){
                wrapperFilteredList.add(wrapR);
            }
        }
        if(wrapperFilteredList.size() > 0){
            wrapperRecords = wrapperFilteredList;
        }
    }
    public void commandLinkActionEdit(){
        showEdit = true;
        showAll = false;
        Integer i = 1;
        Integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index'));
        System.debug('rowNo'+indexVal);
        secondWrapperRecords = new List<WrapperForCountry>();
        System.debug('wrapperRecords : '+wrapperRecords);
        /*for(WrapperForCountry con : wrapperRecords){
if(con.serialNumber == indexVal){
secondWrapperRecords.add(con);
}
}*/
        secondWrapperRecords.add(wrapperRecords.get(indexVal -1));
        System.debug('secondWrapperRecords : ' + secondWrapperRecords);
    }
    public void commandLinkActionDelete(){
        countryRecords = new List<Country__c>();
        Integer indexVal = Integer.valueof(system.currentpagereference().getparameters().get('index'));
        wrapperRecords.remove(indexVal - 1);
    }
    //Method For Master CheckBox Select
    public void masterCheck(){
        if(wrapperRecords.size() > 0){
            for(WrapperForCountry wrapRec : wrapperRecords){
                if(masterCheckBox == true){
                    wrapRec.singleSelectCheckBox = true;
                }
                else{
                    wrapRec.singleSelectCheckBox = false;
                }
            }
        }
    }
    //Method For Uncheck MasterCheckBox
    public void unCheckMasterCheckBox(){
        Integer count = 0;
        for(WrapperForCountry conRec : wrapperRecords){
            if(conRec.singleSelectCheckBox == true){
                count++;
            }
            else{
                masterCheckBox = false;
            }
            if(wrapperRecords.size() == count){
                masterCheckBox = true;
            }
            else{
                masterCheckBox = false;
            }
        }
    }      
    public void submitRecords(){
        countryRecords = new List<Country__c>();
        for(WrapperForCountry conRecWrap : WrapperRecords){
            Country__c submitRecord = new Country__c();
            if(submitRecord.Name != null){
            submitRecord.Name = conRecWrap.countryName;
            submitRecord.State__c = conRecWrap.StateName;
            submitRecord.City__c = conRecWrap.cityName;
            countryRecords.add(submitRecord);
        }
        if(countryRecords.size() > 0){
            Insert countryRecords;
        }
        WrapperRecords.clear();
        secondWrapperRecords.clear();
    }
    }
    public class WrapperForCountry{
        public Integer serialNumber{get;set;}
        public String countryName{get;set;}
        public String stateName{get;set;}
        public String cityName{get;set;}
        public Boolean singleSelectCheckBox{get;set;}
    }
}