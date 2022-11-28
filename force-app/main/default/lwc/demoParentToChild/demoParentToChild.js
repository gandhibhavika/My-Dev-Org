import { LightningElement } from 'lwc';
export default class DemoParentToChild extends LightningElement {

showButton = false;
enteredText;
messageRcvd;
handleChange(event){
     this.showButton = false;
    this.enteredText = event.target.value;
    console.log('this.enteredText : ',this.enteredText);
}

handleClick(){
    this.showButton = true;
    console.log('button Clicked : ');
}

handleMsg(event){
this.messageRcvd = event.detail.operationtype;
console.log('messageRcvd : ',this.messageRcvd);
}
}