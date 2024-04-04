
@isTest
private class DragAndDropTest {
    @TestSetup
    static void makeData(){
        Account account = new Account(Name='test',Gender__c = 'Male');
        insert  account;
        Contact contact = new Contact(LastName='test contact',AccountId = account.Id);
        insert contact;
        Contact contact2 = new Contact(LastName='test contact2',AccountId = account.Id);
        insert contact2;
        Account account2 = new Account(Name='testOne',Gender__c = 'Male');
        insert  account2;
        Account account3 = new Account(Name='testTwo',Gender__c = 'Male');
        insert  account3;
    }

    @isTest
    static void getAccList() {
        List<Account> accList = DragAndDrop.getAccList('test');
        Assert.isNotNull(accList,'The list of accounts should not be null!');
        Assert.areEqual(3,accList.size()); 
    }

    @IsTest
    static void getRelatedContacts(){
        Account account = [select Id from Account where Name ='test'];
        Test.startTest();
        List<Contact> RelatedContacts = DragAndDrop.getRelatedContacts(account.Id);
        Assert.areEqual(2,RelatedContacts.size());
        Test.stopTest();
    }

    @IsTest
    static void changeAccount(){
        Contact contact = [select Id from Contact limit 1];
        Account account = [select Id from Account where Name ='testOne' limit 1];
        Test.startTest();
        DragAndDrop.changeAccount(contact.Id,account.Id);
        Contact checkContact = [select AccountId from Contact where Id=:contact.Id];
        Assert.areEqual(account.Id,checkContact.AccountId);
        Test.stopTest();
    }

    @IsTest
    static void getTotalCount(){
        Test.startTest();
        Account account = [select Id from Account where  Name='test'];
        Integer count = DragAndDrop.getTotalCount(account.Id);
        Assert.areEqual(2,count);
        Test.stopTest();
        
    }
}