@isTest
private class LeadTriggerTestClass {
    @TestSetup
    static void makeData(){
        Lead lead = new Lead();
        lead.LastName = 'Shah';
        lead.Company  = 'MV Clouds';
        lead.Status = 'Open - Not Contacted';
        insert lead;
    }

    @isTest
    static void ratingHotOnInsert() {
        Lead lead = [select Rating from Lead];
        Assert.areEqual('Hot',lead.Rating);
        LeadTriggerHelperClass leadClass = new LeadTriggerHelperClass();
    }
}