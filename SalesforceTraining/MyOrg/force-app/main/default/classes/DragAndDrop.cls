public with sharing class DragAndDrop {
    public DragAndDrop() {

    }
    @AuraEnabled
    public static List<Account> getAccList(String searchString){
        searchString = '%'+searchString+'%';
        List<Account> accList = [select Id,Name from Account where Name like :searchString limit 5];
        return accList;
    }
    @AuraEnabled
    public static List<Contact> getRelatedContacts(Id accountId){
            return [select Id,Name,MobilePhone,Email from Contact where AccountId =:accountId];
    }
    @AuraEnabled
    public static void changeAccount(Id contactId , Id accountId){
        
            System.debug('ContactId = '+contactId + 'AccountId' + accountId);
            Contact contact = [select Id,AccountId from Contact where Id = :contactId];
            contact.AccountId = accountId;
            update contact;
        
    }
    
    @AuraEnabled
    public static Integer getTotalCount(Id accountId){
        
               
            if (accountId != null) {
                return [select count() from Contact where AccountId = :accountId];
            } else {
                return null;
            }
        
    }

}