public with sharing class createContactAura {
    
    // public createContactAura() {
        
    // }
    @AuraEnabled
    public static string createContactApex(String FirstName ,String LastName , Integer Mobile,String Email,Id accountId){
        try {
            Contact contact = new Contact(FirstName = FirstName , LastName = LastName , Phone = Mobile.toString(), Email = Email,AccountId = accountId);
            insert contact;
            
            return 'Contact Inserted';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Account> getAccounts(String searchString){
        try {
            System.debug('search from apex'+ searchString);
            
            searchString = '%'+searchString+'%';
            List<Account> accountList = [select Id,Name from Account where Name like :searchString limit 5];
            System.debug('accountList');

            return accountList; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}