import { LightningElement, api } from 'lwc';
export default class ChildCountryListComponent extends LightningElement {

    @api records;
    @api cNames = [];
    cNotSelected = [];
    isChecked;
    @api url;

    @api count = 0;
    constructor() {
        super();
         console.log('records', this.records);
       
    }

    handleChange(event) {
        if (event.target.checked) {
            this.count++;
            this.cNames.push(event.target.name);
        }
        else {
            this.count--;
            let el = this.cNames.find(itm => itm === event.target.name);
            if (el) this.cNames.splice(this.cNames.indexOf(el), 1);
        }

        console.log('count', this.count);
        console.log('this.cNames', this.cNames);
        
        const countEvent = new CustomEvent('cname', {
            detail: {
                countryName: [...this.cNames],
                concount: this.count
            }
        })
        this.dispatchEvent(countEvent);
console.log('records', this.records);
    }
}