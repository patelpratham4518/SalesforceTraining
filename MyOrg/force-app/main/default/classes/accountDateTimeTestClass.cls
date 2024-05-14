@isTest(seeAllData = true)
private class accountDateTimeTestClass {

    @isTest
    static void batchTest() {
        Test.startTest();
        accountDateTime newBatch = new accountDateTime();
        Database.executebatch(newBatch);
        Test.stopTest();
        Integer count = 0;
        List<Account> accounts   = [select Description from Account ];
        for (Account account : accounts) {
            if (account.Description == null) {
                count += 1;
            }
        }
        Assert.areEqual(0,count);
    }
    @IsTest
    static void scheduleTest(){ 
        Test.startTest();
        accountDateTime newBatch = new accountDateTime();
        String sch = '0 0 9 ? * *';
		System.schedule('Test status Check', sch, newBatch );
        Test.stopTest();
    }
    
}