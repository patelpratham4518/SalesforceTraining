public with sharing class WizardComponent {
    public WizardComponent() {

    }
    @AuraEnabled
    public static Id createAccount(String gender , String name ,String email ,Integer phone , Integer revenue ){
        try {
            Account account = new Account();
            account.Gender__c = gender;
            account.Name = name ; 
            account.Email__c = email;
            account.Phone = phone.toString();
            account.AnnualRevenue = revenue;
            insert account;
            return account.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static Id createContact(String firstName , String lastName ,String email ,Integer phone , Id accountId ){
        try {
            Contact contact = new Contact();

            contact.FirstName = firstName ; 
            contact.LastName = lastName ; 
            contact.Email = email;
            contact.Phone = phone.toString();
            contact.AccountId = accountId;
            insert contact;
            return contact.Id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void createEvent(Id accountId , String eventType){
        try {
            Account account = [select OwnerId from Account where Id =:accountId];

            Event event = new Event();
            event.IsAllDayEvent = true;
            event.ActivityDate = System.today();
            event.OwnerId = account.OwnerId;
            event.Type = eventType;
            event.Subject = 'Wizard Task';
            event.WhatId = accountId;
            insert event;


        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}