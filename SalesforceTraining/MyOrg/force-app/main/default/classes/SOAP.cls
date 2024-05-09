// apex class as soap webService
global with sharing class SOAP {
    
    webService static List<Contact> getRelatedContacts(String accountId) {
      if (accountId == null) {
        System.debug('AccountId not provided');
        return null;
    }    
    
    try {
        List<Contact> contacts = [SELECT Id,Name,Phone,Email FROM Contact WHERE AccountId=:accountId];
        return contacts;
    } catch (Exception e) {
        System.debug('Error ==> '+e.getMessage());
        return null;
    }
    }
}
