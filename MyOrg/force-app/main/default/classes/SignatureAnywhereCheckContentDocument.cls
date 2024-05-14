
@isTest(seeAllData = true)
private class SignatureAnywhereCheckContentDocument {

    
   @IsTest
   static void methodName(){
    System.debug([select Name from Student__c limit 10]);
    User user = [select Username from User where Username = 'signature_anywhere@00d5g00000lqnlfeax.org.force.com'];
    System.debug(user.Username);
    Test.startTest();
        System.runAs(user){
        System.debug('guest user');
        System.debug('Content Document deletable = '+ Schema.sObjectType.ContentDocument.isDeletable());
        System.debug('Content Version insert = '+Schema.sObjectType.ContentVersion.createable);
        System.debug('Content Version upsert = '+Schema.sObjectType.ContentVersion.updateable);
        System.debug('Students =>\n');
        System.debug([select Name from Student__c  limit 10 ]);
        }
    Test.stopTest();
    
   }
}