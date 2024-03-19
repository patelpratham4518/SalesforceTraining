import { LightningElement, api, track } from 'lwc';
import getEmailId from '@salesforce/apex/GMAIL_Integration.getEmailId'
import sendEmail from '@salesforce/apex/GMAIL_Integration.sendEmail'
export default class GmailIntegration extends LightningElement {
    recordId
    toEmail
    subject
    message
    @track attachments = []
    connectedCallback(){
        this.getRecordId(window.location.href)
    }
    getRecordId(href){
        this.recordId = href.split("recordId=")[1].split("&")[0]
        getEmailId({
            recordId : this.recordId
        }).then(response => {
            if (response) {
                this.toEmail = response
            }
        }).catch(error => {
            console.log("Error = ",error);
        })
    }
    handleSubjectChange(event){
        this.subject = event.target.value
    }
    handleMessageChange(event){
        this.message = event.target.value
    }
    handleToEmailChange(event){
        this.toEmail = event.target.value
        
    }
    sendEmail(){
        // console.log(this.attachments);
        // console.log(JSON.stringify(this.attachments));
        // console.log(JSON.parse(JSON.stringify(this.attachments)));
        let base64Array = []
        this.attachments.forEach(element => {
            base64Array.push(element.base64String)
        });
        // console.log(base64Array);
        

        
        sendEmail({
            toEmail : [this.toEmail],
            subject : this.subject,
            message : this.message,
            attachments : base64Array
            // attachments : this.attachments
        }).then(response =>{
            console.log("Email sent",response);
        }).catch(error => {
            console.log("Error = ",error);
        })
    }
    handleUploadFinished(event){
        // console.log("Attached");
        const file = event.target.files[0];
        file.url = URL.createObjectURL(file)
        const reader = new FileReader();
        reader.onloadend = () => {
            const base64String = reader.result
                .replace('data:', '')
                .replace(/^.+,/, '');
            // console.log("base64 = ",base64String);  
            file.base64String = base64String 
            this.attachments.push(file)  
        };
        reader.readAsDataURL(file);
    }

}