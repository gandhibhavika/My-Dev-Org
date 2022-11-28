import { LightningElement, wire, api } from 'lwc';
import FORM_FACTOR from '@salesforce/client/formFactor';
import getRelatedOpp from '@salesforce/apex/GetOpportunityOfAccountLWC.getRelatedOpportunityRecord';

export default class RelatedOpportunityOfAccount extends LightningElement {

 @api recordId;
opportunityData;
opportunityLength;

@wire(getRelatedOpp,{recordId: '$recordId'})
opportunities({data,error}){
    eval("$A.get('e.force:refreshView').fire();");
    if(data){
        this.opportunityData = data;
        console.log('opportunityData : ',this.opportunityData);
        this.opportunityLength = this.opportunityData.length;
    }
    if(error){
        window.console(error);
    }
    
}
get isDesktop() {
        return FORM_FACTOR === 'Large';
    }
}