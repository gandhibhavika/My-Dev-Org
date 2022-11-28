import { LightningElement, api } from 'lwc';
export default class DemoChildofParentToChild extends LightningElement {

@api displayEnteredText;
@api text;

handleClick(event){
event.preventDefault();
this.text = 'Hi Parent'

const sendMsg = new CustomEvent('message', {
    detail: {operationtype: this.text
            }
        })
        this.dispatchEvent(sendMsg);
}
}