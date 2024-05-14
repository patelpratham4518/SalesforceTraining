import { LightningElement, track } from 'lwc';
import getRecords from '@salesforce/apex/LWC6.getRecords'


export default class LWC6 extends LightningElement {
    selected = [];
    searchValue
    responseRecords

    get options() {
        return [
            { label: 'Account', value: 'Account' },
            { label: 'Contact', value: 'Contact' },
            { label: 'Opportunity', value: 'Opportunity' },
            { label: 'Lead', value: 'Lead' },
            { label: 'Student', value: 'Student__c' },
            { label: 'Club', value: 'Club__c' },
            { label: 'Course', value: 'Course__c' },
            { label: 'Debit', value: 'Debit__c' },
            { label: 'Employee', value: 'Employee__c' },
            { label: 'Error_log', value: 'Error_log__c' },
        ];
    }

    get selected() {
        return this.selected.length ? this.selected : 'none';
    }

    handleChange(e) {
        this.selected = e.detail.value;
    }

    searchKeyword(event) {
        this.searchValue = event.target.value;
        
    }
    handleSearchKeyword(){
        console.log(this.searchValue);
        console.log(this.selected);
        getRecords({
            searchValue : this.searchValue,
            selected : this.selected
        }).then(response => {
            console.log('Response = ',response);
            this.responseRecords = response
        }).catch(error => {
            console.log('Error message : ',error);
        })
    }
    
}

        
    

