import { LightningElement,wire } from 'lwc';
import getContact from '@salesforce/apex/GetContactData.getContact';

const records = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Email', fieldName: 'Email'},
    { label: 'Phone', fieldName: 'Phone'},
];

export default class ContactTable extends LightningElement {
columns = records;

contactRecords;

@wire(getContact)
conRecords({data, error}){
    if(data){
       this.contactRecords = data;
    }
    else if(error){
         console.log('error',error);
    }
}


}