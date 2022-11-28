import { LightningElement, wire} from 'lwc';
import getAccountData from '@salesforce/apex/AccountChildContactTreeGridLwc.getAccountData';
 const accColumns = [{
        type: 'text',
        fieldName: 'Name',
        label: 'Name'
    },
    {
        type: 'text',
        fieldName: 'Industry',
        label: 'Industry'
    },
    {
        type: 'text',
        fieldName: 'FirstName',
        label: 'FirstName'
    },
    {
        type: 'text',
        fieldName: 'LastName',
        label: 'LastName'
    }];
    
export default class AccountChildContactTreeGridComponent extends LightningElement {
gridData;
gridColumns = accColumns;
@wire(getAccountData)
    accountTreeData({ error, data }) {

        console.log('Inside wire');
        if ( data ) {
            var tempData = JSON.parse( JSON.stringify( data ) );
            console.log('Data is ' + tempData );
              for ( var i = 0; i < tempData.length; i++ ) {
                tempData[i]._children = tempData[i]['Contacts'];
                delete tempData[i].Contacts;
            }
        this.gridData = tempData;
        }
         else if (error) {
        console.log('error',error);
        }

    }
}