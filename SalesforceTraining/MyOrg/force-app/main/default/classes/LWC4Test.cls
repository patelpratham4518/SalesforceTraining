
@isTest
private class LWC4Test {
    @TestSetup
    static void makeData(){
        List<Account> accList = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account account = new Account(Name = 'test account '+i,Gender__c = 'Male');
            accList.add(account);
        }
        insert accList;
        Contact contact = new Contact(LastName = 'test contact',AccountId = accList[0].Id);
        insert contact;
        Contact contact2 = new Contact(LastName = 'test contact2',AccountId = accList[0].Id);
        insert contact2;
        Opportunity opportunity = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = Date.today(), AccountId = accList[0].Id);
        insert opportunity;
        Opportunity opportunity2 = new Opportunity(Name = 'Test Opportunity2', StageName = 'Prospecting', CloseDate = Date.today(), AccountId = accList[0].Id);
        insert opportunity2;

    }

    @isTest
    static void getAccounts() {
        List<Account> accList = LWC4.getAccounts();
        Assert.areEqual(accList.size(), 5);
        LWC4.AccountWrapper  wrapper= LWC4.getConOpp(accList[0].Id);
        Assert.isNotNull(wrapper);
        Assert.areEqual(wrapper.conList.size(),2);
        Assert.areEqual(wrapper.oppList.size(),2);
    }
}