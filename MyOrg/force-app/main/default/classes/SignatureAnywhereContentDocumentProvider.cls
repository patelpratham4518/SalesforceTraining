global with sharing class SignatureAnywhereContentDocumentProvider {
    public SignatureAnywhereContentDocumentProvider() {

    }

    global static List<Student__c> getContentDocument() {
        System.debug('provider called');
        return [select Id,Name from Student__c ];
        // return [select Name from Student__c WITH SECURITY_ENFORCED];
    }
}