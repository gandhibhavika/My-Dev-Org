import { LightningElement, wire } from 'lwc';
import getAccountRecords from '@salesforce/apex/AccountContactTask.getAccountRecords';
import getContactRecords from '@salesforce/apex/AccountContactTask.getContactRecords';
import getTaskRecords from '@salesforce/apex/AccountContactTask.getTaskRecords';

const columns = [
    { label: 'Subject', fieldName: 'Subject' },
    { label: 'Due Date', fieldName: 'ActivityDate' },
    { label: 'Status', fieldName: 'Status' },
    { label: 'Created By', fieldName: 'CreatedById' },
];

export default class AccountContactTask extends LightningElement {
    columnsList = columns;
    accValue;
    conValue;
    accountOptions;
    contactOptions;
    taskRecords;
    optionsAcc = [];
    optionsCon = [];
    @wire(getAccountRecords)
    accountRecords({ error, data }) {
        if (data) {
            this.accountOptions = data;
            for (let i = 0; i < this.accountOptions.length; i++) {
                if (this.accountOptions != null && this.accountOptions.length > 0) {
                    this.optionsAcc = [...this.optionsAcc, { label: this.accountOptions[i].Name, value: this.accountOptions[i].Id }]
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
        this.optionsCon=[];
        this.taskRecords=[];
        this.accValue = event.target.value;
        console.log('this.value', this.accValue);
        getContactRecords({ accId: this.accValue })
            .then(result => {
                console.log('resulttt=> ', result);
                this.contactOptions = result;
                if (this.contactOptions != null && this.contactOptions.length > 0) {
                console.log('this.contactOptions : ', this.contactOptions);
                for (let i = 0; i < this.contactOptions.length; i++) {
                    console.log('entered in loop');
                    this.optionsCon = [...this.optionsCon, { label: this.contactOptions[i].Name, value: this.contactOptions[i].Id }]
                    console.log('this.optionsCon', this.optionsCon);
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