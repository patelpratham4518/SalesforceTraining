global class addFileToOpportunity {
    public String resImageUrl{get;set;}
    public String imageURL{get;set;}
    public Id oppId;
    
    public HTTPResponse Image;
    public Blob imageBlob;
    public   addFileToOpportunity(ApexPages.StandardController sc) {
        Opportunity opp = (Opportunity) sc.getRecord();
        oppId = opp.Id;             
    }

    public void attach(){
        // System.debug('Img below');
        // imageURL = 'https://source.unsplash.com/random';
        // HttpRequest req = new HttpRequest();
        // req.setEndpoint(imageURL);
        // req.setMethod('GET');
        
        // Http http = new Http();
        // HTTPResponse res = http.send(req);
       

        // String body = res.getBody();
        // resImageUrl = body.split(' ')[4].split('"')[1];
        // System.debug('Response Image= '+resImageUrl);

        

        // HttpRequest reqImage = new HttpRequest();
        // reqImage.setEndpoint(resImageUrl);
        // reqImage.setMethod('GET');
        
        // Http httpImage = new Http();
        // HTTPResponse resImage = http.send(reqImage);
        
        // Attachment attach = new Attachment(parentId = oppId, Name = 'ImgAttachment');
        // attach.Body = resImage.getBodyAsBlob();    
        // attach.ContentType = 'image/jpeg';
 
        // insert attach;
        // System.debug('Image attatched'); 

        futureAttach(imageURL , resImageUrl , oppId );

       
    }
    @Future(callout=true)
    public static void futureAttach(String imageURL , String resImageUrl , String oppId) {
        System.debug('Inside Future');
        System.debug('Img below');
        imageURL = 'https://source.unsplash.com/random';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(imageURL);
        req.setMethod('GET');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
       

        String body = res.getBody();
        resImageUrl = body.split(' ')[4].split('"')[1];
        System.debug('Response Image= '+resImageUrl);

        

        HttpRequest reqImage = new HttpRequest();
        reqImage.setEndpoint(resImageUrl);
        reqImage.setMethod('GET');
        
        Http httpImage = new Http();
        HTTPResponse resImage = http.send(reqImage);
        
        Attachment attach = new Attachment(parentId = oppId, Name = 'ImgAttachment');
        attach.Body = resImage.getBodyAsBlob();    
        attach.ContentType = 'image/jpeg';
 
        insert attach;
        System.debug('Image attatched'); 

        }

   
    
}