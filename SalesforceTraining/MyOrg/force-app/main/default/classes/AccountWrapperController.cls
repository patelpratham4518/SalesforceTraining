public with sharing class AccountWrapperController {
    public AccountWrapperController() {

    }

    public class AccountWrapper {
        @AuraEnabled
        public Account account{get;set;}
        @AuraEnabled
        public List<Contact> conList{get;set;}
        @AuraEnabled
        public List<Opportunity> oppList{get;set;}
    }

    @AuraEnabled
    public static List<AccountWrapper> getAccountWrappers(){
        try {
            List<Account> accList = [select Id,Name ,(select Name,Id from Contacts),(select Name,Id from Opportunities)from Account];
           
            List<AccountWrapper> wrapperList = new List<AccountWrapper>();

            if (accList != null) {
                for (Account account : accList) {
                    AccountWrapper newWrapper = new AccountWrapper();
                    newWrapper.account = account;
                    newWrapper.conList = account.Contacts;                       
                    newWrapper.oppList = account.Opportunities;
                    wrapperList.add(newWrapper);
                }
            }
            return wrapperList;
        } catch (Exception e) {
            System.debug('Error message = '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}
