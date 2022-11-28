import { LightningElement, wire} from 'lwc';
import studentName from "@salesforce/messageChannel/StudentNameMsgChannel__c";
import{MessageContext, publish} from 'lightning/messageService';
export default class SearchStudentCityLmsComponent extends LightningElement {

searchCity;
searchedData;

@wire(MessageContext)
myContext

handleSearch(event){
 this.searchCity = event.target.value;
 console.log('this.searchCity',this.searchCity);
}


handleSearchBtn(){
   console.log('entered in search btn')
   let message = {
        "studentCity" : {
            "value" : this.searchCity
        }
   }

    console.log('published');
    publish(this.myContext, studentName, message)
}
}