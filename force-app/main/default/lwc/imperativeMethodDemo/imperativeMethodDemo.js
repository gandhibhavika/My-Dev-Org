import { LightningElement } from 'lwc';
import getAccountPhone from '@salesforce/apex/ImperativeMethodDemo.getAccountPhone';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import TYPE_FIELD from '@salesforce/schema/Account.Type';

export default class ImperativeMethodDemo extends LightningElement {

searchedValue;
rec={
    Name: NAME_FIELD,
    Phone: PHONE_FIELD,
    Type: TYPE_FIELD
}
handleChange(event){
    if(event.target.label == 'Name'){
this.rec.Name = event.target.value;
    }
    if(event.target.label == 'Phone'){
this.rec.Phone = event.target.value;
    }
     if(event.target.label == 'Type'){
this.rec.Type = event.target.value;
    }
console.log('rec : ',this.rec);

}

handleClick(){
getAccountPhone({sName : this.rec})
}
}