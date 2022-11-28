import { LightningElement, wire } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createAccRecord from '@salesforce/apex/CreateAccountRecordLwc.createAccRecord';

export default class CreateAccountRecordComponent extends LightningElement {
  disableNewAcc = true;
  disableSave = true;
  rec = {
    Name: NAME_FIELD,
    Phone: PHONE_FIELD,
    Type: TYPE_FIELD
  }

  handleClick(event) {
    console.log(event.target.label);
    if (event.target.label == 'Name') {
      this.rec.Name = event.target.value;
      if(this.rec.Name){
        this.disableNewAcc = false;
        this.disableSave = false;
      }
      else{
        this.disableSave = true;
        this.disableNewAcc = true;
      }
    }
    if (event.target.label == 'Phone') {
      this.rec.Phone = event.target.value;
      console.log('this.rec.Phone' + this.rec.Phone);

    }
    if (event.target.label == 'Type') {
      this.rec.Type = event.target.value;
      console.log('this.rec.Type' + this.rec.Type);
    }
  }

handleSave(){
  this.disableSave = true;
  createAccRecord({ accountObj: this.rec })
  console.log('entered' + this.accountObj);
  this.dispatchEvent(
    new ShowToastEvent({
      title: 'Success',
      message: 'Account created',
      variant: 'success'
    })
  )
  console.log('reached here');
this.disableNewAcc = false;
}
newAcc(){
  console.log('inside method');
  this.rec = {};


}
}