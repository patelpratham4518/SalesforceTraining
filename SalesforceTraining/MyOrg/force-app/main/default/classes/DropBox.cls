public with sharing class DropBox {

    public static final String DropBox_Token = 'sl.BxwHnIZ8hdUOUjXyuT2piyKzNm08HW9M4PBBEnpWhQqABSmSp3k4SwsxiRYx0c4mGX3TrskB8Q5R6n_TCM1-TPFitXjAyOFuZD29se1Vw1kDmFyOMrFZnn3McjHwOu4YdwnqfBuUhiRM';

    public static final String DropBox_CreateFolder_URL = 'https://api.dropboxapi.com/2/files/create_folder_v2';

    public DropBox() {

    }
    
    @AuraEnabled
    public static void createFolderForRecordId(String recordId) {
        System.debug('create folder for '+recordId);
        createFolder(recordId);
    }


    @future(callout=true)
    public static void createFolder(String folderName) {

        String body = '{"path":"/' + folderName + '","autorename":false}';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(DropBox_CreateFolder_URL);
        req.setHeader('Authorization', 'Bearer ' + DropBox_Token);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setBody(body);
        Http http = new Http();
        HttpResponse res = http.send(req);        
    }

    @AuraEnabled
    public static void uploadFiles(String recordId, String JSONfile) {
        // System.debug(recordId);
        // System.debug(JSONfile);
        File file = (File) System.JSON.deserialize(JSONfile,File.class);
        // System.debug(file.name);
        // System.debug(file.type);
        // System.debug(file.base64String);
        // uploadFile(recordId,file.name,file.type,EncodingUtil.base64Decode(file.base64String));    


    }

    @future(callout=true)
    public static void uploadFile(String folderName, String fileName, String type ,Blob fileData) {

        String dropboxUploadUrl = 'https://content.dropboxapi.com/2/files/upload';
        String dropboxFilePath = '/' + folderName + '/' + fileName;    
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'path' => dropboxFilePath,
            'mode' => 'add',
            'autorename' => true,
            'mute' => false,
            'strict_conflict' => false
        };
        String requestBody = JSON.serialize(requestBodyMap);   
        HttpRequest req = new HttpRequest();
        req.setEndpoint(dropboxUploadUrl);
        req.setHeader('Authorization', 'Bearer ' + DropBox_Token);
        req.setHeader('Content-Type', type);
        // req.setHeader('Content-Type', 'application/octet-stream');
        req.setHeader('Dropbox-API-Arg', requestBody);
        req.setMethod('POST');
        req.setBodyAsBlob(fileData);   
        Http http = new Http();
        HttpResponse res = http.send(req);      
}

    public class File {
        public String name;
        public String type;
        public String base64String;
    }
}