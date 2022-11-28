import { LightningElement, api } from 'lwc';
export default class CountryCapitalChildComponent extends LightningElement {

    @api records;
    @api url;
    countryRecords;
    countryAttachments
    enter = true;

     connectedCallback(){
         this.clearSelectedValue();
         console.log('url',this.url);
     }
   
    @api clearSelectedValue(){
        console.log('records',this.records);
       this.countryRecords = JSON.parse(JSON.stringify(this.records));
       this.countryAttachments = JSON.parse(JSON.stringify(this.countryRecords.Attachments));
       console.log('attachments',this.countryAttachments);
          console.log('enter a block');
          this.enter = false;
    }
}