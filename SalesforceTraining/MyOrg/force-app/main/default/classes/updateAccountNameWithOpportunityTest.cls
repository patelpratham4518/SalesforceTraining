
@isTest
private class updateAccountNameWithOpportunityTest {

    @IsTest(seeAllData=true)
    static void updateAccountNameWithOpportunity(){
        
        Test.startTest();
        updateAccountNameWithOpportunity batch = new updateAccountNameWithOpportunity();
        Database.executebatch(batch);
        Test.stopTest();
        
    }
}