import { LightningElement, wire } from 'lwc';
import fillWrapper from '@salesforce/apex/LwcAccountContactCount.fillWrapper';
const singlecolumn = [
    { label: 'Name', fieldName: 'accName' },
];
const columns = [
    { label: 'Name', fieldName: 'accName' },
    { label: 'Contacts', fieldName: 'countCon' }
];

export default class AccoutContactCountComponent extends LightningElement {
    columns = singlecolumn;
    wrapperList;
    get options() {
        return [
            { label: 'show count', value: 'show Count' },
        ];
    }
    @wire(fillWrapper)
    accContact({ data, error }) {
        if (data) {
            this.wrapperList = data;
            console.log('Wrapper List', this.wrapperList);
        }
        if (error) {
            console.log('error', error);
        }
    }




    handleChange(event) {
        if (event.target.checked) {
            this.columns = columns;
            console.log('columns', this.columns);
        }
        else {
            this.columns = singlecolumn;
            console.log('singlecolumn', singlecolumn);
        }
    }
}