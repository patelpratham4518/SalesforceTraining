
@isTest
private class createContactAuraTest {
    @TestSetup
    static void makeData(){
        Account account = new Account(Name = 'test account',Gender__c = 'Male');
        insert account;

    }

    @isTest
    static void getAccounts() {
        List<Account> accList = createContactAura.getAccounts('test');
        Assert.areEqual(accList.size(),1);
     
        List<Account> accList2 = createContactAura.getAccounts(null);
        
    }
    @IsTest
    static void createContactApex(){
        
        Test.startTest();
        String res = createContactAura.createContactApex('Pratham','Patel',1000,'rohitbombay45@gmail.com',[select Id from Account limit 1].Id);
        Assert.areEqual(res,'Contact Inserted');
        try {
            
            String res2 = createContactAura.createContactApex('Pratham','Patel',null,'rohitbombay45@gmail.com',[select Id from Account limit 1].Id);
        } catch (Exception e) {
            
        }
        Test.stopTest();
        
    }
}


