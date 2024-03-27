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
    public static String sendEmail(List<String> toEmail , String subject , String message,List<String> attachmentsMap){
        try {
            
            for (String attach : attachmentsMap) {
                attachment file =  (attachment) System.JSON.deserialize(attach, attachment.class);
                System.debug(file.name);
                System.debug(file.type);
                System.debug(file.base64String);
                
            }
            
            
            // Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            // mail.setToAddresses(toEmail);
            // mail.setSubject(subject);
            // mail.setPlainTextBody(message);
            // List<Messaging.EmailFileAttachment> attachList = new List<Messaging.EmailFileAttachment>();
            // for (String attach : attachmentsMap) {
            //     attachment file =  (attachment) System.JSON.deserialize(attach, attachment.class);
            //     Blob attachBlob = EncodingUtil.base64Decode(file.base64String);
            //     Messaging.EmailFileAttachment emailAttachment = new Messaging.EmailFileAttachment();
            //     emailAttachment.setFileName(file.name);
            //     emailAttachment.setContentType(file.type);
            //     emailAttachment.setBody(attachBlob);
            //     attachList.add(emailAttachment);
            // }
            // mail.setFileAttachments(attachList);
            // Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            // System.debug(results);



            // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
            HttpRequest req = new HttpRequest();
            String toAddress = 'patelpratham4518@gmail.com';
            // String subject = 'Testing sending email from salesforce using GMail API';
            // String mailBody = 'Testing sending email from salesforce using GMail API';
            String mbody = '{ "raw" : "' + EncodingUtil.base64Encode(Blob.valueof( 'To: ' + toAddress + '\r\nContent-Type:text/plain; charset=utf-8;\r\nSubject: ' + subject + '\r\n\r\n' + message )) + '"}';
            req.setHeader('Content-Length', mbody.length()+'');
            req.setHeader('Content-Type', 'application/json');
            
            req.setEndpoint('callout:GMAIL_API/gmail/v1/users/patelpratham4518@gmail.com/messages/send');
            //req.setEndpoint('https://gmail.googleapis.com');
            req.setMethod('POST');
            system.debug(mbody);
            req.setBody(mbody);
            // Send the request, and return a response
            Http h = new Http();
            HttpResponse res = h.send(req);
            system.debug(res);



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
