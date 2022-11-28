import { LightningElement } from 'lwc';
export default class SonChildComponent extends LightningElement {

showMsg;
fetchMsg(event){
this.showMsg = event.detail;
}
}