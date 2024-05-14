
@isTest
private class CotactDisplayCompTest {

    @TestSetup
    static void makeData(){
        Account account = new Account(Name ='test account',Gender__c = 'Female');
        insert  account;
        Account account2 = new Account(Name ='test account2',Gender__c = 'Female');
        insert  account2;
        Contact contact1 = new Contact(LastName = 'test contact1',AccountId = account.Id);
        insert contact1;
        Contact contact2 = new Contact(LastName = 'test contact2',AccountId = account.Id);
        insert contact2;
        Contact contact3 = new Contact(LastName = 'test contact3');
        insert contact3;
        Contact contact4 = new Contact(LastName = 'contact4');
        insert contact4;
    }

    @isTest
    static void getConList() {
         List<Contact> conList = CotactDisplayComp.getConList('test');
         Assert.areEqual(conList.size(),3);
    }

    @IsTest
    static void getRelatedContacts(){
        Account account = [select Id from Account where Name = 'test account'];

        Test.startTest();
        List<Contact> conList = CotactDisplayComp.getRelatedContacts(account.Id);
        
        Assert.areEqual(conList.size(),2);
        Test.stopTest();
    }

    @IsTest
    static void getAllContacts(){

        Test.startTest();
        List<Contact> conList = CotactDisplayComp.getAllContacts();
        Assert.areEqual(conList.size(),4);
        Test.stopTest();
        
    }
}