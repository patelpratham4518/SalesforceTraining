import { LightningElement,wire } from 'lwc';
import getConOpp from'@salesforce/apex/LWC4.getConOpp';
import { MessageContext, subscribe } from 'lightning/messageService';
import LWC4MC from '@salesforce/messageChannel/LWC4MC__c';




export default class Contactoppolwc extends LightningElement {
    @wire(MessageContext)MessageContext
    subscription = null

    conList
    oppList

    getContactOpportunity(accountId){
       
        getConOpp({
            accountId : accountId
        }).then(result => {
            this.conList = result.conList
            this.oppList = result.oppList
            console.log('Contact List :',this.conList);
            console.log('Opportunity list',this.oppList);
        })
    }

    subscribeToMessageChannel(){
        this.subscription = subscribe(this.MessageContext,LWC4MC,(message)=>{
            this.getContactOpportunity(message.accountId)
        })
    }

    connectedCallback(){
        console.log("Connected called");
        this.subscribeToMessageChannel()
        
    }
    


}
