public class SelectedSobjectFieldsController {
    public Map <String, Schema.SObjectType> schemaObjects = Schema.getGlobalDescribe();
    public List<SelectOption> objNames{get;set;}
    public List<SelectOption> fieldNames{get;set;}
    public List<SelectOption> addedFields{get;set;}
    public String selectedObject{get; set;}
    public String finalSelectedField{get;set;}
    public set<String> allSfields{get;set;}
    public set<String> fNotSelected{get;set;}
    public List<String> selectedFields{get; set;}
    String customLabelValue = System.Label.pagination;
    // public List<FieldWrapper> listField{get;set;}
    
    public SelectedSobjectFieldsController() {
        objNames = new List<SelectOption>();
        fieldNames = new List<SelectOption>();
        addedFields = new List<SelectOption>();
        selectedFields = new List<String>();
        allSfields = new Set<String>();
        fNotSelected = new Set<String>();
        //listField = new List<FieldWrapper>() ;
        ListObjectName();
    }
    
    // find all sObjects available in the organization
    public void ListObjectName() {
        objNames.add(new SelectOption('None','---Select---'));
        //List<SelectOption> objNames = new List<SelectOption>();
        for(String name : schemaObjects.keyset())
            if(schemaObjects.get(name).getDescribe().isCustom() || customLabelValue.containsIgnoreCase(name) 
               && schemaObjects.get(name).getDescribe().isQueryable()){
                   String label = schemaObjects.get(name).getDescribe().getLabel();
                   objNames.add(new SelectOption(name,label));
                   objNames.sort();
                   system.debug('select '+objNames);
               }
    }
    
    public void objectFields(){ 
        system.debug('entered');
        if(selectedObject!= null && !selectedObject.equalsIgnoreCase('None')){
            fieldNames = new List<SelectOption>();
            //Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            Schema.SObjectType ObjectSchema = schemaObjects.get(selectedObject);
            Map<String, Schema.SObjectField> fieldMap = ObjectSchema.getDescribe().fields.getMap();
            for (String fieldName: fieldMap.keySet()){ 
                //if(fieldMap.get(fieldName).getDescribe().isSortable() && fieldMap.get(fieldName).getDescribe().isUpdateable()){
                String label = fieldMap.get(fieldName).getDescribe().getLabel();
                fNotSelected.add(label);
                fieldNames.add(new SelectOption(label,label));
                system.debug('fNames= '+fieldNames);
                system.debug('fnotselected= '+fNotSelected);
                //}
            }
            
        }           
    }
    
    public void displayNSfields(){
        system.debug('Entered in clearing method');
        fieldNames.clear();
        addedFields.clear();
        For(String  str: fNotSelected){
            system.debug('loop of fntselected');
            fieldNames.add(new SelectOption(str , str));
        }
        
        if(selectedFields!= null && selectedFields.size() > 0){
            For(String allsField : allSfields){
                system.debug('allsField= '+allsField);
                system.debug('allSfields= '+allSfields);
                addedFields.add(new SelectOption(allsField , allsField));
            }
        }
    }
    
    public void addFields(){
        System.debug('selectedFields : ' + selectedFields);
        allSfields.addAll(selectedFields);
        if(fNotSelected.size() > 0){
        fNotSelected.removeAll(selectedFields);
        }
        displayNSfields();
    }
}