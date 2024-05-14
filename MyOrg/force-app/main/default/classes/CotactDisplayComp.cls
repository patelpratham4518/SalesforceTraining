public with sharing class CotactDisplayComp {
    public CotactDisplayComp() {

    }

    @AuraEnabled
    public static List<Contact> getConList(String searchString){
        searchString = '%'+searchString+'%';
        List<Contact> conList = [select Id,Name,AccountId from Contact where Name like :searchString limit 5];
        return conList;
    }

    @AuraEnabled
    public static List<Contact> getRelatedContacts(Id accountId){
        
        
        
            return [select Id,Name,MobilePhone,Email from Contact where AccountId =:accountId];
        
        
    }

    @AuraEnabled
    public static List<Contact> getAllContacts(){
       return [select Id,Name,MobilePhone,Email from Contact ];
    }
}