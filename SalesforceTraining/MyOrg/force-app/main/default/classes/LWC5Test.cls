@isTest
private class LWC5Test {
    @TestSetup
    static void makeData(){
        List<Account> accList = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            Account account = new Account(Name = 'test account '+i,Gender__c = 'Male');
            accList.add(account);
        }
        accList[0].Email__c = 'acc.t@testclass.com';
        insert accList;
        Contact contact = new Contact(LastName = 'test contact',AccountId = accList[0].Id,Email = 'con.t@testclass.com');
        insert contact;
        Lead lead = new Lead(Salutation = 'Mr.', LastName = 'test',Company = 'test company',Email = 'lead.t@testclass.com');
        insert lead;
    }

    @isTest
    static void getObjectList() {
        List<Object> accList = LWC5.getObjectList('Account');
        Assert.areEqual (5,accList.size());
        try {      
            List<Object> contList = LWC5.getObjectList('Student');
            Assert.fail();
        } catch (Exception e) {
            
        }
    }
    @IsTest
    static void getEmailId(){
        Id accId = [select Id from Account where Email__c != null limit 1].Id;
        String accEmail = LWC5.getEmailId('Account',accId);
        Assert.areEqual(accEmail,'acc.t@testclass.com');
        
        Id conId = [select Id from Contact limit 1].Id;
        String conEmail = LWC5.getEmailId('Contact',conId);
        Assert.areEqual(conEmail,'con.t@testclass.com');

        Id leadId = [select Id from Lead limit 1].Id;
        String leadEmail = LWC5.getEmailId('Lead',leadId);
        Assert.areEqual(leadEmail,'lead.t@testclass.com');

        String nullEmail = LWC5.getEmailId('Student__c',leadId);
        Assert.isNull(nullEmail);        
    }

    @IsTest
    static void sendEmail(){
      LWC5.sendEmail(new List<String>{'lead.t@testclass.com','acc.t@testclass.com'},'test class','testing send email functionality');
    }
}