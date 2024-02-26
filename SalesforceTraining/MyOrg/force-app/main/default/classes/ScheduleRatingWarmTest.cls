
@isTest
private class ScheduleRatingWarmTest {

    @isTest(seeAllData=true)
    static void ratingSchedule() {
        Test.startTest();
        ScheduleRatingWarm newBatch = new ScheduleRatingWarm();
        String sch = '0 25 12 ? * *';
		System.schedule('Test status Check', sch, newBatch );   
        Test.stopTest();
    }
}