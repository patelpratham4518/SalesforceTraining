@isTest
private class ScheduleCreateOppTestClass {

    @isTest
    static void oppSchedule() {
        Test.startTest();
        ScheduleCreateOpp newBatch = new ScheduleCreateOpp();
        String sch = '0 25 12 ? * *';
		System.schedule('Test status Check', sch, newBatch );   
        Test.stopTest();
    }


    @IsTest(seeAllData=true)
    static void updateAccountNameWithOpportunity(){
        
        Test.startTest();
        updateAccountNameWithOpportunity batch = new updateAccountNameWithOpportunity();
        Database.executebatch(batch);
        Test.stopTest();
        
    }
}