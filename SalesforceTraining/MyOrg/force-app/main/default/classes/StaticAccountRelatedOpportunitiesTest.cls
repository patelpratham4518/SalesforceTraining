@isTest
private class StaticAccountRelatedOpportunitiesTest {
    @isTest
    static void getOpportunities() {
        Account account = new Account(Name = 'Acc1',Gender__c = 'Male');
        insert account;
        Opportunity opp1 = new Opportunity(Name = 'opp1', StageName = 'Prospecting', CloseDate = Date.today(),AccountId = account.Id);
        insert opp1;
        Opportunity opp2 = new Opportunity(Name = 'opp2', StageName = 'Prospecting', CloseDate = Date.today(),AccountId = account.Id);
        insert opp2;
        Opportunity opp3 = new Opportunity(Name = 'opp3', StageName = 'Prospecting', CloseDate = Date.today(),AccountId = account.Id);
        insert opp3;
        List<Opportunity> oppList = StaticAccountRelatedOpportunities.getOpportunities(account.Id);
        Assert.areEqual(3,oppList.size());
    }
}