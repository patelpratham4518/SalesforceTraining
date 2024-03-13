@isTest
private class AccountTestClass {

    @IsTest
    static void addPrefix_deleteSameNameAccount_createContact_sendEmailWhenNameChange(){
        
        Test.startTest();
        Account account = new Account();
        account.Name = 'Yogi';
        account.Gender__c = 'Male';
        account.Phone = '7984237081';
        insert account;
        account = [select Name from Account where Id =: account.Id];
        // System.assertEquals('Mr.Yogi',account2.Name);
        //Checks Prefix
        Assert.areEqual('Mr.Yogi',account.Name);  
        
        Account account2 = new Account();
        account2.Name = 'Yogi';
        account2.Gender__c = 'Male';
        insert account2;
        Integer count = [select count() from Account];
        System.debug('Count = '+count);
        //checks Account with same name is deleted
        Assert.areEqual(1,count);
        account = [select Name ,Phone,Rating,Total_Amount__c from Account];
        Assert.isNull(account.Phone);

        Integer relatedContactCount = [select count() from Contact where AccountId =: account.Id];
        //Checks related Contact is created
        Assert.areEqual(1,relatedContactCount);

        Contact relatedContact = [select Amount__c,Email from Contact where AccountId =: account.Id];
        relatedContact.Email = 'patelpratham4518@gmail.com';
        update relatedContact;

        account.Name = 'Narendra';
        account.Max_Amount_For_Contact__c = 1000;
        account.Rating = 'Hot';
        update account;

        relatedContact = [select Amount__c from Contact where AccountId =: account.Id];
        relatedContact.Amount__c = 500;
        update relatedContact;
        account = [select Name,Total_Amount__c from Account];
        //checks setTotalAmount
        Assert.areEqual(500 , account.Total_Amount__c);

        Test.stopTest();
        
    }

    @IsTest
    static void methodName(){
        
        Test.startTest();

        Account account = [select Name from Account];
        Assert.areEqual('Mr.Yogi',account.Name);  
        
        Test.stopTest();
        
    }
    @TestSetup
    static void makeData(){
        Account account = new Account();
        account.Name = 'Yogi';
        account.Gender__c = 'Male';
        account.Phone = '7984237081';
        insert account;

    }


}