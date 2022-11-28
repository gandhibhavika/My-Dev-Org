import { LightningElement, wire , api , track} from 'lwc';
import fetchAccount from '@salesforce/apex/AccountContactLwcController.fetchAccount'; 

export default class accountContactLwc extends LightningElement {
@track multiple = false;
@track accounts ;
@wire(fetchAccount)
wiredAccountss({
    error,
    data
}) {
    if (data) {
        this.accounts = data;
        console.log('hello= '+data);
        console.log(JSON.stringify(data, null, '\t'));
        
        // data.forEach(function (item, key) {
        //     console.log(key); 
        //     console.log(item); 
       // });
        
    } else if (error) {
        this.error = error;
    }
}
}