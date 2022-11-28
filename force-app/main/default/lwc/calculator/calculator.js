import { LightningElement  } from 'lwc';
export default class Calculator extends LightningElement {

fnumber;
snumber;
resultValue;

handleEvent1(event){
this.fnumber = event.target.value;
console.log('fNum '+this.fnumber);
}

handleEvent2(event){
this.snumber = event.target.value;
console.log('sNum '+this.snumber);
}

Addition(event){
    this.resultValue = parseInt(this.fnumber) + parseInt(this.snumber);
}
Subtraction(event){
    this.resultValue = parseInt(this.fnumber) - parseInt(this.snumber);
}
Multiplication(event){
    this.resultValue = parseInt(this.fnumber) * parseInt(this.snumber);
}
Division(event){
    this.resultValue = parseInt(this.fnumber) / parseInt(this.snumber);
}


}


/*function Add(evt){
this.resultValue = parseInt(this.template.querySelector("lighting-input[data-txt-id=inputFirst]").value) +
parseInt(this.template.querySelector("lighting-input[data-txt-id=inputSecond]").value)
}*/