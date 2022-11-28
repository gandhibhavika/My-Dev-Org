import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { getRecord, getRecordNotifyChange } from 'lightning/uiRecordApi';

import deleteSelectedContactRecord from '@salesforce/apex/DeleteContactRecordLWC.deleteSelectedContactRecord';
export default class DeleteAllContactsOnAccountQuickAction extends LightningElement {

@api recordId
 @api invoke(){
    deleteSelectedContactRecord({ accId:  this.recordId})
    
    this.dispatchEvent(
            new ShowToastEvent({
                title: "Deleted Successfully",
                message: "Refresh Page to check!",
                variant: "success"
            })
        );
              //getRecordNotifyChange([{recordId: this.recordId}]);

        //eval("$A.get('e.force:refreshView').fire();");
 }
}