@isTest
private class ContactTriggerTestClass {
    @TestSetup
    static void makeData(){
        Account account = new Account();
        account.Name = 'Yogi';
        account.Gender__c = 'Male';
        account.Max_Amount_For_Contact__c = 1000;
        insert Account;
        Contact contact = [select Id,Name from Contact];
        
    }


    @isTest
    static void deleteRelatedAccount() {
        Test.startTest();

        Contact contact = [select Id,Name from Contact];
        delete contact;
        Integer accountCount = [select count() from Account];
        System.debug('Account Count = '+accountCount);
        Assert.areEqual(0,accountCount);

        Test.stopTest();
    }

    @IsTest
    static void setTotalAmountUpdate(){
        
        Test.startTest();
        Contact contact = [select Id,Name,Amount__c from Contact];
        contact.Amount__c = 600;
        update contact;
        Account account = [select Total_Amount__c from Account];
        Assert.areEqual(600,account.Total_Amount__c);
        
        Test.stopTest();
        
    }

    @IsTest
    static void changeSibblingAccount(){
        Test.startTest();
        Account account  = [select Id from Account];
        Contact contact2 = new Contact();
        contact2.LastName = 'contact2';
        contact2.AccountId = account.Id;
        insert contact2;
        Integer contactCount = [select count() from Contact where AccountId=:account.Id];
        Assert.areEqual(2,contactCount);
        
        Account account2 = new Account();
        account2.Name = 'account2';
        account2.Gender__c = 'Female';
        insert account2;

        contact2.AccountId  = account2.Id;
        update contact2;
        contactCount = [select count() from Contact where AccountId=:account2.Id];
        System.debug('contactCount = '+contactCount);
        Assert.areEqual(3,contactCount);

        Test.stopTest();
    }

    @IsTest
    static void checkMaxAmount(){
        Test.startTest();
        
        Account account = [select Id from Account];
        Integer contactCount = [select count() from Contact where AccountId =:account.Id];
        Assert.areEqual(1,contactCount);
        Contact contact = [select Id,Name,Amount__c from Contact];
        contact.Amount__c = 3500;
        update contact;
        contactCount = [select count() from Contact where AccountId =:account.Id];
        Assert.areEqual(4,contactCount);
        
        Test.stopTest();
    }

}