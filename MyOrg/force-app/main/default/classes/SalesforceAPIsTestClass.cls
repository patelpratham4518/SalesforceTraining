@isTest
public class SalesforceAPIsTestClass {
    @TestSetup
    static void makeData(){
     Account account = new Account(Name = 'test account',Gender__c = 'Male');
     insert account;
     List<Contact> conList = new List<Contact>();
     for (Integer i = 0; i < 5; i++) {
        Contact contact = new Contact(LastName = 'test contact '+i,AccountId = account.Id);
        conList.add(contact);
     }   
     insert conList;

    }
    @isTest
    static void testpostMethod() {
    
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/myOrg/object';
        req.httpMethod = 'POST';
        req.addParameter('object', 'Contact');
        req.addParameter('limit', '3');
        req.addParameter('fields', 'Id,Name,AccountId');

        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        SalesforceAPI.postMethod();
        Test.stopTest();
        List <Object> contacts = (List<Object>) JSON.deserializeUntyped((res.responseBody).toString());
        Assert.areEqual(3, contacts.size());
        System.assertEquals(200, res.statusCode);

    }
    @isTest
    static void testpostMethodError() {
    
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/myOrg/object';
        req.httpMethod = 'POST';
        req.addParameter('object', 'Student');
        req.addParameter('limit', '3');
        req.addParameter('fields', 'Id,Name,AccountId');

        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        SalesforceAPI.postMethod();
        Test.stopTest();
        System.debug(res.responseBody.toString());
        System.assertEquals(400, res.statusCode);

    }

    @IsTest
    static void testGetMethod(){
        
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/myOrg/object';
        req.httpMethod = 'GET';
        req.addHeader('Object', 'Contact');
        req.addHeader('Id', [select  Id from Contact limit 1].Id);
        req.addHeader('fields', 'Id,Name,AccountId');


        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        SalesforceAPI.getMethod();
        System.debug('Response body ==>  '+(res.responseBody).toString());
        Object  contact = (Object)JSON.deserializeUntyped((res.responseBody).toString());
        System.debug(contact);
        Assert.isNotNull(contact,'The response is not null');
        System.assertEquals(200, res.statusCode);
        Test.stopTest();
        
    }
    @IsTest
    static void testGetMethodError(){
        
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/myOrg/object';
        req.httpMethod = 'GET';
        req.addHeader('Object', 'Student');
        req.addHeader('Id', [select  Id from Contact limit 1].Id);
        req.addHeader('fields', 'Id,Name,AccountId');


        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        SalesforceAPI.getMethod();
        System.debug('Response body ==>  '+(res.responseBody).toString());
        System.assertEquals(400, res.statusCode);
        Test.stopTest();
        
    }


}