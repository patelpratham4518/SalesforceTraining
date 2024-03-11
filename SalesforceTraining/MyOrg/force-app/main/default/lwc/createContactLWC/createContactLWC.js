import { LightningElement } from 'lwc';
import createContact from "@salesforce/apex/ContactLWC.createContact";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class CreateContactLWC extends LightningElement {
    salutationsList = [
        { label: 'Mr.', value: 'Mr.' },
        { label: 'Ms.', value: 'Ms.' },
        { label: 'Mrs.', value: 'Mrs.' },
        { label: 'Dr.', value: 'Dr.' },
        { label: 'Prof.', value: 'Prof.' },
    ];

    get salutationOptions() {
        return this.salutationsList;
    }   

    handleClick(event){
        let salutation = this.template.querySelector('lightning-input-name').salutation
        let firstName = this.template.querySelector('lightning-input-name').firstName
        let lastName = this.template.querySelector('lightning-input-name').lastName
        let email = this.template.querySelector('[data-id="email"]').value
        let phone = this.template.querySelector('[data-id="phone"]').value
        let DOB = this.template.querySelector('[data-id="DOB"]').value
        // console.table(salutation,firstName,lastName,email,phone,DOB)
        // console.log("Type of phone",typeof phone);
        
        createContact({
            salutation : salutation,
            firstName : firstName,
            lastName : lastName,
            email : email,
            DOB : DOB,
            phone : phone
        }).then(result => {
            this.showToast()
            console.log("Success");
        }).catch(error => {
            console.log("Error = ",error);
        })

       
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Contact Inserted',
            message: 'Contact Inserted',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

}