import { LightningElement, api } from 'lwc';
import accountRecord from '@salesforce/apex/AccountParentLwcController.accountRecord';

export default class AccountParentRecord extends LightningElement {

@api recordId;

getAccountData(){
   accountRecord({accId:this.recordId});
   
}
}