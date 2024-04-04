
// @isTest(seeAllData = true)
@isTest
private class LWC6Test {
    @TestSetup
    static void makeData(){
        Account account = new Account(Name = 'test account',Gender__c = 'Male');
        insert account;
        Contact contact = new Contact(Salutation = 'Mr.', LastName = 'test contact');
        insert contact;
        Lead lead = new Lead(Salutation = 'Mr.', LastName = 'test laed',Company = 'test company',Email = 'lead.t@testclass.com');
        insert lead;
    }

    @isTest
    static void myUnitTest() {
   
        List<LWC6.ObjectWrapper> wrapperList = LWC6.getRecords('test',new List<String>{'Account','Contact','Lead'});
        System.debug(wrapperList);
        System.debug('sosl search ==> '+ [FIND  'test' IN ALL FIELDS RETURNING Account(Id,Name),Contact(Id,Name),Lead(Id,Name)]); 
        Assert.areEqual(wrapperList.size(),3);
    }
}


