import { LightningElement } from 'lwc';
export default class DaughterChildComponent extends LightningElement {

strmsg;

handleClick(){
    this.strmsg = 'Miss You Brother..!';
 this.dispatchEvent( new CustomEvent('pass', {
            detail: this.strmsg
        } ) );
}
}