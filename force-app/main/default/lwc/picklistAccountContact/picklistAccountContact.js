import { LightningElement, wire } from 'lwc';

import getAccountRecords from '@salesforce/apex/PicklistAccountContactLwc.getAccountRecords';
import getContactRecords from '@salesforce/apex/PicklistAccountContactLwc.getContactRecords';
import getTaskRecords from '@salesforce/apex/PicklistAccountContactLwc.getTaskRecords';

const taskColumns = [
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'Due Date', fieldName: 'ActivityDate' },
    { label: 'Status', fieldName: 'Status' },
    { label: 'Created By', fieldName: 'CreatedById' },
];
export default class PicklistAccountContact extends LightningElement {

columns = taskColumns;
    accValue;
    conValue;
    accountOptions;
    contactOptions;
    taskRecords;
    displayAccOptions = [];
    displayConOptions = [];
    @wire(getAccountRecords)
    accountRecords({ error, data }) {
        if(data){
            this.accountOptions = data;
            for (let i = 0; i < this.accountOptions.length; i++) {
                if (this.accountOptions != null && this.accountOptions.length > 0) {
                    this.displayAccOptions = [...this.displayAccOptions, { label: this.accountOptions[i].Name, value: this.accountOptions[i].Id }]
                }
                console.log(this.accountOptions);
            }
        }
        if (error) {
            console.log('error ', error);
        }
}

handleChangeAccount(event) {
        this.conValue = null;
        this.displayConOptions=[];
        this.taskRecords=[];
        this.accValue = event.target.value;

        getContactRecords({ accId: this.accValue })
            .then(result => {
                this.contactOptions = result;
                console.log('OUTPUT RESULT : ',result);
                if (this.contactOptions != null && this.contactOptions.length > 0) {
                console.log('this.contactOptions : ', this.contactOptions);
                for (let i = 0; i < this.contactOptions.length; i++) {
                    this.displayConOptions = [...this.displayConOptions, { label: this.contactOptions[i].Name, value: this.contactOptions[i].Id }]
                    console.log('this.displayConOptions', this.displayConOptions);
                }
                }
            })
            .catch(error => {
                this.error = error;
            });
    }

    handleChangeContact(event) {
        this.conValue = event.target.value;
        console.log('this.conValue', this.conValue);
        getTaskRecords({ conId: this.conValue })
            .then(result => {
                if (result != null) {
                console.log('resulttt task=> ', result);
                this.taskRecords = result;
                console.log('this.taskRecords : ', this.taskRecords);
                }
            })
            .catch(error => {
                this.error = error;
                console.log('error',this.error);
            });
    }
}