public with sharing class ContactLWC {
    public ContactLWC() {

    }
    // @AuraEnabled(cacheable=true)
    @AuraEnabled
    public  static void createContact(String salutation,String firstName,String lastName,String email,Date DOB,String phone) {
        System.debug('apex called');
        Contact contact = new Contact();
        contact.Salutation = salutation;
        contact.FirstName = firstName;
        contact.LastName = lastName;
        contact.Email = email;
        contact.Birthdate = DOB;
        contact.Phone = phone;
        insert contact;
        System.debug('From apex : '+ salutation+firstName+lastName+email+DOB+phone);
    }
}