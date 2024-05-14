
@isTest
public class AccountWrapperControllerTest {

    @TestSetup
    static void makeData(){       
    }
    @isTest
    public static void testGetAccountWrappers() {
        
        
        Account account = new Account(Name = 'Test Account',Gender__c = 'Male');
        insert account;
    
        Contact contact = new Contact(LastName = 'Test Contact', AccountId = account.Id);
        insert contact;
    
        Opportunity opportunity = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = Date.today(), AccountId = account.Id);
        insert opportunity;
        
        List<AccountWrapperController.AccountWrapper> accountWrappers = AccountWrapperController.getAccountWrappers();

        System.assertEquals(1, accountWrappers.size(), 'The method should return 1 AccountWrapper');
        AccountWrapperController.AccountWrapper accountWrapper = accountWrappers[0];
        System.assertEquals(account.Id, accountWrapper.account.Id, 'The account in the AccountWrapper should be the one we created');
        System.assertEquals(1, accountWrapper.conList.size(), 'The AccountWrapper should have 1 contact');
        System.assertEquals(contact.Id, accountWrapper.conList[0].Id, 'The contact in the AccountWrapper should be the one we created');
        System.assertEquals(1, accountWrapper.oppList.size(), 'The AccountWrapper should have 1 opportunity');
        System.assertEquals(opportunity.Id, accountWrapper.oppList[0].Id, 'The opportunity in the AccountWrapper should be the one we created');
    }
}