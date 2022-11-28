import { LightningElement, wire } from 'lwc';
import getContentVersion from '@salesforce/apex/CountryListLwc.getContentVersion';
import getCountryRecords from '@salesforce/apex/CountryListLwc.getCountryRecords';
export default class ParentCountryListComponent extends LightningElement {

    countryData;
    countryId;
    urlCountry;
    linkedEntityId=[];
    selectedCountry;
    
    selectedCountryString;
    @wire(getCountryRecords)
    country({data, error}){
   
        if(data){
            this.countryData = data
            console.log('countryData', this.countryData[0].Id);
            //this.countryId = this.countryData.Id;
           // this.linkedEntityId.push(this.countryData.Id);
            //this.urlCountry= '/sfc/servlet.shepherd/version/download/';
            //console.log('linkedEntityId : ',this.linkedEntityId);
            this.handleContentVersion();
        }
        if(error){
            this.error = error;
            console.log('error',this.error); 
        }
    }

    handleContentVersion() {
        for(let i = 0; i < this.countryData.length; i++){
                 this.linkedEntityId.push(this.countryData[i].Id);
        console.log('this.countryData[i].Id',this.countryData[i].Id);
        }
       console.log('linkedEntityId : ',this.linkedEntityId);
        getContentVersion({ cId:  this.linkedEntityId})
            .then(result => {
                console.log('resulttt=> ', result);
                this.urlCountry = '/sfc/servlet.shepherd/version/download/' + result[0].Id;
                console.log('urlCountry', this.urlCountry);
            })
            .catch(error => {
                this.error = error;
            });
                 
    }

    handleDetail(event){
        console.log('entered');
        this.selectedCountry = event.detail.countryName;
         console.log('this.countryName',this.selectedCountry);
       
        this.selectedCountryString = JSON.parse(JSON.stringify(this.selectedCountry));
        console.log('JSON.stringify(this.selectedCountry)', JSON.parse(JSON.stringify(this.selectedCountry)));
    }
}
//how to print value of array in html 
//how to remve element from name in array of js in lwc