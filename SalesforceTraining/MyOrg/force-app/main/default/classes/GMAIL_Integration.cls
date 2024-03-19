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
    public static String sendEmail(List<String> toEmail , String subject , String message,List<String> attachments,List<String> attachmentsMap){
        try {
            // System.debug(attachmentsMap);
            for (String attach : attachmentsMap) {
                attachment file =  (attachment) System.JSON.deserialize(attach, attachment.class);
                System.debug(file.name);
                System.debug(file.type);
                System.debug(file.base64String);
                
            }
            
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toEmail);
            mail.setSubject(subject);
            mail.setPlainTextBody(message);
            List<Messaging.EmailFileAttachment> attachList = new List<Messaging.EmailFileAttachment>();
            for (String attach : attachmentsMap) {
                attachment file =  (attachment) System.JSON.deserialize(attach, attachment.class);
                Blob attachBlob = EncodingUtil.base64Decode(file.base64String);
                Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
                emailAttachment.setFileName(file.name);
                emailAttachment.setContentType(file.type);
                emailAttachment.setBody(attachBlob);
                attachList.add(emailAttachment);
            }
            mail.setFileAttachments(attachList);
            // for (String attachment : attachments) {
            //     Blob attachBlob = EncodingUtil.base64Decode(attachment);
            //     Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
            //     emailAttachment.setFileName('attachment');
            //     emailAttachment.setBody(attachBlob);
            //     mail.setFileAttachments(new Messaging.EmailFileAttachment[] {emailAttachment});
            // }
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            System.debug(results);
            return 'Success';
        } catch (Exception e) {
            System.debug(e);
            throw new AuraHandledException(e.getMessage());
        }
    }

    public class attachment{
        public String name;
        public String type;
        public String url;
        public String base64String;
    }
}