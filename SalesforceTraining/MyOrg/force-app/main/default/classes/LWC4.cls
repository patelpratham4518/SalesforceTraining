public with sharing class LWC4 {
    // public LWC4() {

    // }
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        // try {
            System.debug('Apex called');
            List<Account> accList = [select Id,Name from Account];
            return accList;
            
        // } catch (Exception e) {
        //     throw new AuraHandledException(e.getMessage());
        // }
    }

    @AuraEnabled
    public static AccountWrapper getConOpp(String accountId){
        // try {
            AccountWrapper  wrapper= new AccountWrapper();
            wrapper.conList = [select Id,Name from Contact where AccountId =:accountId];
            wrapper.oppList = [select Id,Name from Opportunity where AccountId =:accountId];
            return wrapper;
        // } catch (Exception e) {
        //     throw new AuraHandledException(e.getMessage());
        // }
    }

    public class AccountWrapper {
        @AuraEnabled
        public List<Contact> conList{get;set;}
        @AuraEnabled
        public List<Opportunity> oppList{get;set;}
    }
    
}