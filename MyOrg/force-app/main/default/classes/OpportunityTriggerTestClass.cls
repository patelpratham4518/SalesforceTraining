@isTest
private class OpportunityTriggerTestClass {
    @TestSetup
    static void makeData(){
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Vaidik Patel';
        opportunity.CloseDate = System.today();
        opportunity.StageName = 'Prospecting';
        insert opportunity;

        opportunity.StageName = 'Negotiation/Review';
        opportunity.Name = 'Mauli Patel';
        update opportunity;
    }

    @isTest
    static void typeNewCustomer() {
        Opportunity opportunity = [select Type from Opportunity];
        Assert.areEqual('New Customer',opportunity.Type);
    }
    @IsTest
    static void stageNameAndCloseDate(){
        Test.startTest();
        Opportunity opportunity = [select CloseDate,StageName from Opportunity];
        Assert.areEqual(Date.today().addDays(15),opportunity.CloseDate);
        Assert.areEqual('Prospecting',opportunity.StageName);
        Test.stopTest();
    }
    @IsTest
    static void createTaskForOwner(){        
        Test.startTest();
        Opportunity opportunity = [select Id,OwnerId from Opportunity];
        Task task = [select subject,Type from Task where OwnerId=:opportunity.OwnerId];
        System.debug('TaskSize = '+ task);
        Assert.isNotNull(task);
        Test.stopTest();        
    }
}