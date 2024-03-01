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
}