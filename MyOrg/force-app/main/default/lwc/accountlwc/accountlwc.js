import { LightningElement,wire } from 'lwc';
import getAccounts from'@salesforce/apex/LWC4.getAccounts';
import LWC4MC from '@salesforce/messageChannel/LWC4MC__c'
import { MessageContext, publish } from 'lightning/messageService';




export default class ComboboxRequired extends LightningElement {
    @wire(MessageContext)MessageContext
    options
    
    @wire (getAccounts) accounts({error,data}){
        if (data) {
            // console.log("Data");
            // console.log(typeof data);
            this.options = data.map(option =>{
                return{
                    label: option.Name,
                    value : option.Id
                }
            })
            
        }
    };
    value 
   
    handleChange(event) {
        this.value = event.detail.value;   
        console.log(this.value); 
        publish(this.MessageContext,LWC4MC,{accountId : event.detail.value})
        
        
    }

    
}
