import { LightningElement, wire } from 'lwc';
import getStudentsByCity from '@salesforce/apex/getStudentDetailLwc.getStudentRecords'
import studentName from '@salesforce/messageChannel/StudentNameMsgChannel__c'
import studentRecordId from '@salesforce/messageChannel/StudentIdMsgChannel__c'
import { MessageContext, subscribe, unsubscribe, APPLICATION_SCOPE, publish } from 'lightning/messageService';
export default class StudentDetailLmsComponent extends LightningElement {

    selectedCity;
    students;
    mySubscription;
    recordId;

    @wire(MessageContext)
    myContext;

    connectedCallback() {
        this.handleGetStudentsByCity();
        this.messageSubscribe();
    }

    handleGetStudentsByCity() {
        getStudentsByCity({ sCity: this.selectedCity })
            .then(result => {
                this.students = result;

            }).catch(error => {
                console.log('Error ', error);
            });

    }

    messageSubscribe() {
        this.mySubscription = subscribe(this.myContext, studentName, (message) => {
            this.handleSubscriptionMessage(message);
        }, { scope: APPLICATION_SCOPE })
    }

    handleSubscriptionMessage(message) {
        this.selectedCity = message.studentCity.value ? message.studentCity.value : '';
        this.handleGetStudentsByCity();
    }

    messageUnsubscribe() {
        unsubscribe(this.mySubscription);
        this.mySubscription = null;
    }

    disconnectedCallback() {
        this.messageUnsubscribe();
    }

    handleShowDetails(event) {
        this.recordId = event.target.dataset.stuId;
        let message = {
            "studentId": {
                "value": this.recordId
            }
        }
            publish(this.myContext, studentRecordId, message)
        
    }
}