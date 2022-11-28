import { LightningElement , wire , api , track} from 'lwc';
import getcustomerRecords from '@salesforce/apex/CustomerRecordLwc.getcustomerRecords';

export default class CustomerCityFilterComponent extends LightningElement {
    value='All';
 records = [
{label: 'Contact Name' , fieldName: 'Name'},
{label: 'Email' , fieldName: 'email__c'},
{label: 'State' , fieldName: 'State__c'},
{label:   'City' , fieldName: 'All_Cities__c'}
];
columns  = this.records;
customers;
cityCustomer;
options = [];
@wire(getcustomerRecords)
cstmrRecords({error, data }) 
{
if (data) {
    this.cityCustomer = data;
this.customers = data;
console.log('OUTPUT : this.customers',this.customers);
let opt =[];
for(let i = 0; i < this.customers.length; i++){
    if(opt.includes(this.customers[i].All_Cities__c)){
        console.log('this.customers[i].All_Cities__c',this.customers[i].All_Cities__c);
        continue;
    }
    else{
        opt = [...opt,this.customers[i].All_Cities__c];
    }
console.log('OUTPUT : this.customers.All_Cities__c',this.customers[i].All_Cities__c);
} 
let s1 = {label:'All', value:'All'};
     this.options.push(s1);
for(let i = 0; i < opt.length; i++){
    this.options = [...this.options,{label:opt[i], value:opt[i]}]
}

console.log('options',this.options);    
this.error = undefined;
} else if (error) {
this.error = error;
this.customers = undefined;
}
}

 handleCity(event){
  var cityValue = (event.target.value);
  console.log('city',cityValue);
 if(cityValue != 'All'){
 this.cityCustomer = this.customers.filter(Customer =>Customer.All_Cities__c.indexOf(cityValue) !== -1);
 console.log('this.cityCustomer',this.cityCustomer);
 } 
 else{
     this.cityCustomer = this.customers;
 }
 }
 }