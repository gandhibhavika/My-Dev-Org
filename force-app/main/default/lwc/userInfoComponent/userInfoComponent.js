import { LightningElement, wire } from 'lwc';
import getUsersInfo from '@salesforce/apex/UsersInfoLwc.getUsersInfo';
//import getUsersCount from '@salesforce/apex/UsersInfoLwc.getUsersCount';
export default class UserInfoComponent extends LightningElement {

searchUser;
searchedData;
userData;
totalUser;
filteredUserData;

@wire(getUsersInfo)
userRecords({data , error})
{
if(data){
    this.userData = data;
    this.filteredUserData = data;
    console.log('my all data', this.filteredUserData);
    
    this.totalUser = this.filteredUserData.length;
console.log('totalUser',this.totalUser);
}
else if(error){
    this.error = error;
}
}

handleSearch(event){
 this.searchUser = event.target.value;
 console.log('this.searchUser',this.searchUser);
}

onSearchBtn(){
    console.log('entered in search btn')
if(this.searchUser != null){
    this.filteredUserData = this.userData.filter(User =>User.Name.indexOf(this.searchUser) !== -1);
}
else{
   this.filteredUserData =  this.userData;
}
this.totalUser = this.filteredUserData.length;
}
}