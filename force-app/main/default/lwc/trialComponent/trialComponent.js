import { LightningElement } from 'lwc';
export default class TrialComponent extends LightningElement {
value;
showInChild;

handleChange(event){
    console.log('entered');
this.value = event.target.value;
console.log('this.enteredValue',this.value);
}
handleClick(){
this.showInChild = this.value;
console.log('showInChild',showInChild);
 this.template.querySelectorAll(
            'lightning-input-field'.forEach(field => {
                field.reset();
            }),
 )

}
}