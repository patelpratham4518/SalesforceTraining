
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

        // attach.ContentType = 'image/jpeg';
 
        insert attach;
        System.debug('Image attatched'); 
        //futureAttach(imageURL , resImageUrl , oppId );

       
    }
    @future
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

        Blob binaryData = Blob.valueOf(resImageUrl);
        System.debug('Blob Image =  '+binaryData);

        // String base64String = EncodingUtil.base64Encode(binaryData);
        // System.debug('bsae64string = '+ base64String);

        //  // decode base64
        //  Blob blobContent = EncodingUtil.base64Decode(base64String);
        //  System.debug('blobContent = '+ blobContent);
        //  // Blob to string
        //  String decodeBase64String = blobContent.toString();
        //  System.debug('decodebase64String = '+ decodeBase64String);


        Attachment attach = new Attachment(parentId = oppId, Name = 'ImgAttachment');
        attach.Body = binaryData;    
        attach.ContentType = 'text/plain';
        
        // Attachment attach = new Attachment(parentId = oppId, Name = 'ImgAttachment');
        // attach.Body = res.getBodyAsBlob();

        //Attachment attach = new Attachment(parentId = oppId, Name = 'ImgAttachment.html');
        //attach.Body = Blob.valueOf('<img src="'+resImageUrl+'"/>');
        //attach.ContentType = 'text/html';
             
        // Attachment attach = new Attachment(parentId = oppId, Name = 'ImgAttachment.jpeg');
        // attach.Body = Blob.valueOf(res.getBody());
        // attach.ContentType = 'image/jpeg';
 
        insert attach;
        System.debug('Image attatched'); 


    }

   
    
}