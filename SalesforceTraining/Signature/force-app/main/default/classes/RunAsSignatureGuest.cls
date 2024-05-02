
@isTest(seeAllData = true)
private class RunAsSignatureGuest {

   @IsTest
   static void methodName(){
    User guestUser = [select Id,Name from User where Username = 'signature_anywhere@00dh30000000rdfmaa.org.force.com' limit 1];
    System.debug([select Name from Contact]);


    Test.startTest();
    System.runAs(guestUser){
        System.debug('Running as guest user cv');
        System.debug('ContentVersionCreatable => '+ Schema.sObjectType.ContentVersion.createable);
        // System.debug('ContactRetrievable => '+ Schema.sObjectType.Contact.retrieveable);
        
        Contact contact = new Contact(LastName = 'guest user');
        insert contact;
        contact.LastName = 'updateName';
        try {
            update contact;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
        System.debug([select Name from Contact]);
    }
    Test.stopTest();


    System.debug([select Name from Contact]);   
   }
}