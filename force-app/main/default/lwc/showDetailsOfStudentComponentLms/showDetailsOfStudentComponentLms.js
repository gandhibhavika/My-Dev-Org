import { LightningElement, wire } from 'lwc';
import getStudentDetailById from '@salesforce/apex/getStudentDetailLwc.getStudentDetailById';
import studentRecordId from '@salesforce/messageChannel/StudentIdMsgChannel__c';
import { MessageContext, subscribe, unsubscribe, APPLICATION_SCOPE} from 'lightning/messageService';
export default class ShowDetailsOfStudentComponentLms extends LightningElement {

recordId
students;

 @wire(MessageContext)
    myContext

connectedCallback() {
        this.handleGetStudentDetailById();
        this.messageSubscribe();
        console.log('studentRecordId is:  ', studentRecordId);
    }

    handleGetStudentDetailById() {
        console.log('this.recordId : ',this.recordId);
        if(this.recordId){
        getStudentDetailById({stdId: this.recordId})
            .then(result => {
                this.students = result;
                console.log('this.students : ',this.students);
            }).catch(error => {
                console.log('Error ',error);
            });
        }
    }

    messageSubscribe() {
        this.mySubscription = subscribe(this.myContext, studentRecordId, (message) => {
            console.log('Entered in message Subscribe method : ', studentRecordId);
            this.handleSubscriptionMessage(message);
        }, { scope: APPLICATION_SCOPE })
    }

    handleSubscriptionMessage(message) {
        this.recordId = message.studentId.value ? message.studentId.value : '';
        this.handleGetStudentDetailById();
    }

    messageUnsubscribe() {
        unsubscribe(this.mySubscription);
        this.mySubscription = null;
    }
    
    disconnectedCallback() {
        this.messageUnsubscribe();
    }
}