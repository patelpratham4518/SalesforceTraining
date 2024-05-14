@isTest
private class Error_Log_TestClass {

    @isTest
    static void myUnitTest() {
        try {
            Student__c x;
            insert x;
            
        } catch (Exception e) {
            Error_Log error = new Error_Log(e);
        }
        Integer newError = [select count() from Error_log__c];
        Assert.areEqual(1,newError);
    }
}