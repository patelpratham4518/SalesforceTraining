public with sharing class DropBox {
    public static final String DropBox_CreateFolder_URL = 'https://api.dropboxapi.com/2/files/create_folder_v2';

    // public static  String DropBox_Token = '';
    
    public static  String DropBox_Refresh_Token = 'Unb0AZw7-ocAAAAAAAAAAcY4_0-PQErfYEzFK7h1UJcgc8ELkGAqlO9b88I87PxR';
    public static final String DropBox_App_Key = 'hky6aln24sfvfu6';
    public static final String DropBox_App_Secret = 'wmaqqqnefush0wa';
    



    public DropBox() {

    }

    @AuraEnabled
    public static String setToken(){
        System.debug('Inside refresh token');
        String access_token;
        String DropBox_ACCESS_TOKEN_URL = 'https://api.dropbox.com/oauth2/token';
       
        String requestBody = 'grant_type=refresh_token&refresh_token=' + DropBox_Refresh_Token + '&client_id=' + DropBox_App_Key + '&client_secret=' + DropBox_App_Secret;
        HttpRequest req = new HttpRequest();
        req.setEndpoint(DropBox_ACCESS_TOKEN_URL);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setBody(requestBody);
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = http.send(req);
        JSONParser parser = JSON.createParser(res.getBody());
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
                String fieldName = parser.getCurrentName();
                parser.nextToken();
                String fieldValue = parser.getText();
                if (fieldName == 'access_token') {
                    access_token = fieldValue;
                }
            }
            
        }
        return access_token;
    }
    
    @AuraEnabled
    public static void createFolderForRecordId(String recordId, String DropBox_Token) {
        System.debug('create folder for '+recordId);
        createFolder(recordId,DropBox_Token);
    }


    @future(callout=true)
    public static void createFolder(String folderName,String DropBox_Token) {
        System.debug('access token = '+ DropBox_Token);
        String body = '{"path":"/' + folderName + '","autorename":false}';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(DropBox_CreateFolder_URL);
        req.setHeader('Authorization', 'Bearer ' + DropBox_Token);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setBody(body);
        Http http = new Http();
        HttpResponse res = http.send(req);     
        System.debug('createFoder Status = '+res.getStatus());
    }

    @AuraEnabled
    public static void uploadFiles(String recordId, String JSONfile,String DropBox_Token) {
        System.debug('JSON FILE ==> '+JSONfile);
        File file = (File) System.JSON.deserialize(JSONfile,File.class);
        uploadFile(recordId,file.name,EncodingUtil.base64Decode(file.base64String),DropBox_Token);    
    }

    @future(callout=true)
    public static void uploadFile(String folderName, String fileName,Blob fileData,String DropBox_Token) {

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
        req.setHeader('Content-Type', 'application/octet-stream');
        req.setHeader('Dropbox-API-Arg', requestBody);
        req.setMethod('POST');
        req.setBodyAsBlob(fileData);   
        Http http = new Http();
        HttpResponse res = http.send(req);      
        System.debug('File Upload Status = '+res.getStatus());   

}

    public class File {
        public String name;
        public String type;
        public String base64String;
    }
    
    // @future(callout=true)
    public static List<String> listFolder(String folderName,String DropBox_Token) {
        System.debug('Inside Listing');
        String dropBoxListingUrl = 'https://api.dropboxapi.com/2/files/list_folder';
        
        String dropboxFilePath = '/' + folderName ;  
    
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'include_deleted' => false,
            'include_has_explicit_shared_members' => false,
            'include_media_info' => false,
            'include_mounted_folders' => true,
            'include_non_downloadable_files' => true,
            'path' => dropboxFilePath,
            'recursive' => false
        };  
        String requestBody = JSON.serialize(requestBodyMap);   
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(dropBoxListingUrl);
        req.setHeader('Authorization', 'Bearer ' + DropBox_Token);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setBody(requestBody);
        Http http = new Http();
        HttpResponse res = http.send(req);    
        System.debug('Get Listing Status = '+res.getStatus());  
        Folder folder = (Folder) System.JSON.deserialize(res.getBody(),Folder.class);
        
        List<String> fileNames = new List<String>();
        for (Entry entry : folder.entries) {
            fileNames.add(entry.name);
        }
        System.debug(fileNames);
        return fileNames;

               
    }

    public class Folder {
        public String cursor;
        public List<Entry> entries;
        public Boolean has_more;
    }

    public class Entry{
        public String tag;
        public String client_modified;
        public String content_hash;
        public File_lock_info file_lock_info;
        public Boolean has_explicit_shared_members;
        public String id;
        public Boolean is_downloadable;
        public String name;
        public String path_display;
        public String path_lower;
        public List<Property_groups> property_groups;
        public String rev;
        public String server_modified;
        public Sharing_info sharing_info;
        public Integer size;    
    }

    public class File_lock_info{
        public String created;
        public Boolean is_lockholder;
        public String lockholder_name;
    } 

    public class Sharing_info{
        public String modified_by;
        public String parent_shared_folder_id;
        public Boolean read_only;
    }

    public class property_groups {
        public List<Field> fields;
        public String template_id;
    }

    public class Field{
        public String name;
        public String value;
    }

    @AuraEnabled
    public static List<String> FilesListing(String recordId,String DropBox_Token){
        try {
            List<String> fileNames = listFolder(recordId,DropBox_Token);
            return fileNames; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void DeleteFile(String folderName , String fileName,String DropBox_Token){
        try {
        String dropBoxDeleteUrl = 'https://api.dropboxapi.com/2/files/delete_v2';
        String dropboxFilePath = '/' + folderName +'/'+fileName;  
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'path' => dropboxFilePath
        };  
        String requestBody = JSON.serialize(requestBodyMap);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(dropBoxDeleteUrl);
        req.setHeader('Authorization', 'Bearer ' + DropBox_Token);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setBody(requestBody);
        Http http = new Http();
        HttpResponse res = http.send(req);    
        System.debug('Get Delete Status = '+res.getStatus()); 
        System.debug(res.getBody());

            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    @AuraEnabled
    public static String DownloadFile(String folderName , String fileName,String DropBox_Token){
    // public static void DownloadFile(String folderName , String fileName){
        // public static Blob DownloadFile(String folderName , String fileName){
        try {
        String dropBoxDownloadUrl = 'https://content.dropboxapi.com/2/files/download';
        String dropboxFilePath = '/' + folderName +'/'+fileName;  
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'path' => dropboxFilePath
        };  
        String requestBody = JSON.serialize(requestBodyMap);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(dropBoxDownloadUrl);
        req.setHeader('Authorization', 'Bearer ' + DropBox_Token);
        req.setHeader('Dropbox-API-Arg', requestBody);
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse res = http.send(req);    
        System.debug('Get Download Status = '+res.getStatus()); 
        // System.debug(res.getBody());
        String base64String = EncodingUtil.base64Encode(res.getBodyAsBlob());
        System.debug(base64String);
        return EncodingUtil.base64Encode(res.getBodyAsBlob());
        // return res.getBodyAsBlob();
        // return res.getBody();
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}

