import { LightningElement,track ,wire} from 'lwc';
import getObjectList from '@salesforce/apex/LWC5.getObjectList'
import getEmailId from '@salesforce/apex/LWC5.getEmailId'
import sendEmail from '@salesforce/apex/LWC5.sendEmail'
import {ShowToastEvent} from 'lightning/platformShowToastEvent';


export default class LWC5 extends LightningElement {


    @track currentStep = '1';
 
    handleOnStepClick(event) {
        this.currentStep = event.target.value;
    }
 
    get isStepOne() {
        return this.currentStep === "1";
    }
 
    get isStepTwo() {
        return this.currentStep === "2";
    }
 
    get isStepThree() {
        return this.currentStep === "3";
    }
 
    get isEnableNext() {
        return this.currentStep != "3";
    }
 
    get isEnablePrev() {
        return this.currentStep != "1";
    }
 
    get isEnableFinish() {
        return this.currentStep === "3";
    }
 
    handleNext(){
        if(this.currentStep == "1"){
            this.currentStep = "2";
        }
        else if(this.currentStep = "2"){
            this.setToEmail()
            this.currentStep = "3";
        }
    }
 
    handlePrev(){
        if(this.currentStep == "3"){
            this.currentStep = "2";
        }
        else if(this.currentStep = "2"){
            this.currentStep = "1";
        }
    }
 
    handleFinish(){
        sendEmail({
            emailList : this.emailList,
            subject : this.subject,
            message : this.message
        }).then(response => {
            
            this.showSuccessToast()
        }).catch(error => {
            console.log("Error = ",error);
        })
    }

    objects = [
        {
            label : "Account",
            value : "Account"
        },
        {
            label : "Contact",
            value : "Contact",
        },
        {
            label : "Lead",
            value : "Lead"
        }
    ]

    objectType
    @track objectList
    @track iconName
    selectedRecordsEmail = new Map()
    emailList
    

    handleObjectSelection(event){
        this.objectType = event.detail.value
        this.iconName = `standard:${this.objectType}`
        getObjectList({
            objectType : this.objectType
        }).then(response => {
            this.objectList = response
        }).catch(error => {
            console.log("Error = ",error);
        })

    }

    selectRecord(event){

        let selectedRecord = event.target.value
        if (event.target.checked) {

            getEmailId({
                objectType : this.objectType,
                recordId : event.target.value
            }).then(email => {
                if (email) {
                    this.selectedRecordsEmail.set(selectedRecord,email)
                }
                
            }).catch(error => {
                console.log("Error = ",error);
            })

        }
        else{
            this.selectedRecordsEmail.delete(selectedRecord)
        }
    }

    subject
    handleSubjectChange(event){
        this.subject = event.target.value
    }
    message
    handleMessageChange(event){
        this.message = event.target.value
    }
    toEmail
    setToEmail(){
        // this.toEmail = this.selectedRecordsEmail.values().toArray().join(" , ")
        this.emailList = this.selectedRecordsEmail.values().toArray()
        // const emailSet = new Set(this.emailList)
        // const emailArray = Array.from(emailSet)
        this.toEmail = this.emailList.join(" , ")
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Success',
            message: 'Email Sent Sucessfully !!!',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    


}