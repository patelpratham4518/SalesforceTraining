public with sharing class GMAIL_Integration {
    public GMAIL_Integration() {

    }
    @AuraEnabled
    public static string getEmailId(string recordId){
        try {
            Contact contact= [select Email from Contact where Id =:recordId];
            return contact.Email;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String sendEmail(List<String> toEmail , String subject , String message,List<String> attachments){
        try {
            System.debug(attachments);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toEmail);
            mail.setSubject(subject);
            mail.setPlainTextBody(message);
            for (String attachment : attachments) {
                Blob attachBlob = EncodingUtil.base64Decode(attachment);
                Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                emailAttachment.setFileName('attachment');
                emailAttachment.setBody(attachBlob);
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttachment});
            }
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            System.debug(results);
            return 'Success';
        } catch (Exception e) {
            System.debug(e);
            throw new AuraHandledException(e.getMessage());
        }
    }
}