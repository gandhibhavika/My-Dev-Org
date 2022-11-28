import { LightningElement, wire } from 'lwc';
import getCountryName from '@salesforce/apex/CountryCapitalLwc.getCountryName';
import getCountryRecords from '@salesforce/apex/CountryCapitalLwc.getCountryRecords';
import getContentVersion from '@salesforce/apex/CountryCapitalLwc.getContentVersion';
export default class CountryCapitalParentComponent extends LightningElement {

    showChildContactCmp = false;
    options = [];
    countryNameData;
    contactRecord;
    countryId;
    urlCountry;
    contactAttachments;
    @wire(getCountryName)
    countriesName({ data, error }) {
        if (data) {
            this.countryNameData = data;
            for (let i = 0; i < this.countryNameData.length; i++) {
                this.options = [...this.options, {
                    label: this.countryNameData[i].Name, value: this.countryNameData[i].Name
                }]

                console.log('OUTPUT : this.countryNameData.Name', this.countryNameData[i].Name);
            }
        }
        if (error) {
            console.log('error: ', error);
        }
    }

    handleChange(event) {
        var countryName = event.target.value
        getCountryRecords({ cName: countryName })
            .then(result => {
                console.log('namee:=> ', countryName);
                this.contactRecord = result;
                this.countryId = result.Id;
                console.log('result: ', this.contactRecord);
                
            })
            .catch(error => {
                this.error = error;
            });

    }

    // handleContentVersion() {
    //     console.log('entered in handle');

    // }

    handleContactBtn(event) {
        getContentVersion({ cId: this.countryId })
            .then(result => {
                console.log('resulttt=> ', result);
                this.urlCountry = '/sfc/servlet.shepherd/version/download/' + result.Id;
                console.log('urlCountry', this.urlCountry);
            })
            .catch(error => {
                this.error = error;
            });
        this.template.querySelector('c-country-capital-child-component')?.clearSelectedValue()
        this.showChildContactCmp = true;
    }

}