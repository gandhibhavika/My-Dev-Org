import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccountName from '@salesforce/apex/CreateContactOnAccountLWC.getAccountName';
import { CloseActionScreenEvent } from 'lightning/actions';


export default class CreateContactOnAccount extends LightningElement {

    @api recordId;
    accName;
    contactObj;
    message;
    account;
    rec = {
        Fname: '',
        Lname: '',
        Email: '',
        AccountId: '',
    }

    connectedCallback() {
        this.objectApiName = 'Contact';
        console.log('recordId 1 : ', this.recordId);
    }

    @wire(getAccountName, { accId: '$recordId' })
    wiredAccount({ error, data }) {
        console.log('entered in wire : ');
        if (data) {
            console.log('recordId : ', this.recordId);
            this.account = data;
            this.accName = this.account.Name;
            console.log('this.accName : ', this.accName);

            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.accName = undefined;
        }
    }


    handleInputField(event) {
        if (event.target.fieldName == 'FirstName') {
            this.rec.Fname = event.target.value;
            //console.log('this.rec.Fname' + this.rec.Fname);
        }

        if (event.target.fieldName == 'LastName') {
            this.rec.Lname = event.target.value;
            //console.log('this.rec.Lname' + this.rec.Lname);

        }
        if (event.target.fieldName == 'Email') {
            this.rec.Email = event.target.value;
            //console.log('this.rec.Email' + this.rec.Email);
        }
    }

    handleSuccess(event) {
        console.log('this.rec.Lname : ', JSON.stringify(this.rec.Lname));
        if (this.rec.Lname === '') {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Failed',
                    message: 'Last name is required',
                    variant: 'Base',
                }),
            );
        }
        else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Account created',
                    variant: 'success',
                }),
            );
            this.dispatchEvent(new CloseActionScreenEvent());   
eval("$A.get('e.force:refreshView').fire();");
        }
    }
    handleCancel() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
}