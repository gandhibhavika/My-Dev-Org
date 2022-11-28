import { LightningElement , api, wire, track} from 'lwc';
import showContact from '@salesforce/apex/ContactRecord.showContact';

const records = [
    {label: 'Contact Name' , fieldName: 'Name'},
    {label: 'Phone' , fieldName: 'Phone'},
    {label: 'Email' , fieldName: 'Email'}
];
export default class Practice extends LightningElement {

columns  = records  
@wire(showContact)
conReccords
}