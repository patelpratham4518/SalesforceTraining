@isTest
public class WizardComponentTestClass {
    @TestSetup
    static void makeData(){
        Account account = new Account(Name='test account',Gender__c='Female');
        insert account;
    }
    @isTest
    static void testCreateAccount() {
        
        String gender = 'Male';
        String name = 'Test Account';
        String email = 'test@example.com';
        Integer phone = 1234567890;
        Integer revenue = 100000;

    
        Id accountId = WizardComponent.createAccount(gender, name, email, phone, revenue);

      
        Account testAccount = [SELECT Id, Name, Gender__c, Email__c, Phone, AnnualRevenue FROM Account WHERE Id = :accountId];
        
        System.assertEquals('Male', testAccount.Gender__c);
        System.assertEquals('Test Account', testAccount.Name);
        System.assertEquals('test@example.com', testAccount.Email__c);
        System.assertEquals('1234567890', testAccount.Phone);
        System.assertEquals(100000, testAccount.AnnualRevenue);

        try {
            Id accountId2 = WizardComponent.createAccount('LGTV', name, email, phone, revenue);
        } catch (Exception e) {
            
        }
    }

    @isTest
    static void testCreateContact() {
       
        String firstName = 'John';
        String lastName = 'Doe';
        String email = 'john.doe@example.com';
        Integer phone = 1234567890;
        Id accountId = [select Id from Account limit 1].Id;

        
        Id contactId = WizardComponent.createContact(firstName, lastName, email, phone, accountId);

        
        Contact testContact = [SELECT Id, FirstName, LastName, Email, Phone, AccountId FROM Contact WHERE Id = :contactId];

        System.assertEquals('John', testContact.FirstName);
        System.assertEquals('Doe', testContact.LastName);
        System.assertEquals('john.doe@example.com', testContact.Email);
        System.assertEquals('1234567890', testContact.Phone);
        System.assertEquals(accountId, testContact.AccountId);
    }

    @isTest
    static void testCreateEvent() {
        // Prepare test data
        Id accountId = [select Id from Account limit 1].Id;

        String eventType = 'Event Type';

        // Call the method
        WizardComponent.createEvent(accountId, eventType);

        // Verify that the event was inserted
        Event testEvent = [SELECT Id, IsAllDayEvent, ActivityDate, OwnerId, Type, Subject, WhatId FROM Event WHERE WhatId = :accountId];

        System.assertEquals(true, testEvent.IsAllDayEvent);
        System.assertEquals(Date.today(), testEvent.ActivityDate);
        System.assertEquals(UserInfo.getUserId(), testEvent.OwnerId);
        System.assertEquals(eventType, testEvent.Type);
        System.assertEquals('Wizard Task', testEvent.Subject);
        System.assertEquals(accountId, testEvent.WhatId);
    }
}