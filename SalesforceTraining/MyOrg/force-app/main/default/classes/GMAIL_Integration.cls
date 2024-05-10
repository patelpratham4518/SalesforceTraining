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

    // @AuraEnabled
    // public static String sendEmail(List<String> toEmail , String subject , String message,List<String> attachmentsMap){
    //     // try {
    //     //     String attachString = '';
    //     //     for (String attach : attachmentsMap) {
    //     //         attachment file =  (attachment) System.JSON.deserialize(attach, attachment.class);
    //     //         attachString +=  'Content-Type:'+file.type+';name="'+file.name+'"\n ';
    //     //         attachString += 'Content-Transfer-Encoding: base64\n';
    //     //         attachString += 'Content-Disposition: attachment; filename="' + file.name + '"\n\n';
    //     //         attachString += file.base64String+'\n' ;
    //     //     }
    //     //     HttpRequest req = new HttpRequest();
    //     //     String toAddress = toEmail[0];
    //     //     String mbody = '{ "raw" : "' + EncodingUtil.base64Encode(Blob.valueof( 'To: ' + toAddress + '\r\nContent-Type:text/plain; charset=utf-8;\r\nSubject: ' + subject + '\r\n\r\n' + message +'\n'+attachString)) + '"}';
    //     //     req.setHeader('Content-Length', mbody.length()+'');
    //     //     req.setHeader('Content-Type', 'application/json');
    //     //     req.setEndpoint('callout:Gmail_API/gmail/v1/users/patelpratham4518@gmail.com/messages/send');
    //     //     req.setMethod('POST');
    //     //     req.setBody(mbody);
    //     //     Http h = new Http();
    //     //     HttpResponse res = h.send(req);
    //     //     system.debug('Response of send email ==>'+res);

    //     //     return 'Success';
    //     // } catch (Exception e) {
    //     //     System.debug(e);
    //     //     throw new AuraHandledException(e.getMessage());
    //     // }
        
    // }

    @AuraEnabled
    public static String sendEmail(List<String> toEmail, String subject, String message, List<String> attachmentsMap) {
        System.debug('Send Email called');
        try {
            // Initialize raw email content
            String rawEmail = '';

            // Construct email headers
            rawEmail += 'From: patelpratham4518@gmail.com\n';
            rawEmail += 'To: ' + String.join(toEmail,',') + '\n';
            rawEmail += 'Subject: ' + subject + '\n';
            rawEmail += 'MIME-Version: 1.0\n';
            rawEmail += 'Content-Type: multipart/mixed; boundary="email-boundary"\n\n';

            // Create the body of the email
            rawEmail += '--email-boundary\n';
            rawEmail += 'Content-Type: text/plain; charset="UTF-8"\n\n';
            rawEmail += message + '\n';

            // Add each attachment
            for (String attach : attachmentsMap) {
                Attachment file = (Attachment) System.JSON.deserialize(attach, Attachment.class);
                // Attachment headers and content
                rawEmail += '--email-boundary\n';
                rawEmail += 'Content-Type: ' + file.type + '; name="' + file.name + '"\n';
                rawEmail += 'Content-Transfer-Encoding: base64\n';
                rawEmail += 'Content-Disposition: attachment; filename="' + file.name + '"\n\n';
                rawEmail += file.base64String + '\n';
            }

            // Close the MIME boundary
            rawEmail += '--email-boundary--\n';

            // Convert the raw email content to base64 encoding
            String rawEmailEncoded = EncodingUtil.base64Encode(Blob.valueOf(rawEmail));

            // Create the HTTP request
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:Gmail_API/gmail/v1/users/patelpratham4518@gmail.com/messages/send');
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setBody('{"raw":"' + rawEmailEncoded + '"}');

            // Send the request
            Http http = new Http();
            HttpResponse res = http.send(req);

            // Check the response status
            if (res.getStatusCode() == 200) {
                return 'Success';
            } else {
                System.debug('Error sending email: ' + res.getBody());
                throw new AuraHandledException('Failed to send email: ' + res.getStatus());
            }
        } catch (Exception e) {
            System.debug('Exception in sendEmail: ' + e);
            System.debug('Exception in sendEmail: ' + e.getMessage());
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



