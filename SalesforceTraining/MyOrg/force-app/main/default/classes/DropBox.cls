public with sharing class DropBox {
    public static final String DropBox_CreateFolder_URL = 'https://api.dropboxapi.com/2/files/create_folder_v2';

    // public static  String DropBox_Token = 'sl.ByIsA6Snj9abp3nF6N1IJIihbX8BRDnTjAeyx3R6Np7YbdmF9P3IsPiEgcd69GEQFzbWm8eC10aZC2y3UtS6cXaTvegal7CanQwCyWe7E9jm08pPi7vDkragPqGDqSi5RGZFScbcquoB3m_KK9YN';
    public static  String DropBox_Token = '';
    
    public static  String DropBox_Refresh_Token = 'Unb0AZw7-ocAAAAAAAAAAcY4_0-PQErfYEzFK7h1UJcgc8ELkGAqlO9b88I87PxR';
    public static final String DropBox_App_Key = 'hky6aln24sfvfu6';
    public static final String DropBox_App_Secret = 'wmaqqqnefush0wa';
    



    public DropBox() {

    }

    public static void setToken(){
        System.debug('refersh token');
        String DropBox_ACCESS_TOKEN_URL = 'https://api.dropbox.com/oauth2/token';
        Map<String, Object> requestBodyMap = new Map<String, Object>{
            'refresh_token' => DropBox_Refresh_Token,
            'grant_type' => 'refresh_token',
            'client_id' => DropBox_App_Key,
            'client_secret' => DropBox_App_Secret
        };
        String requestBody = JSON.serialize(requestBodyMap); 
        HttpRequest req = new HttpRequest();
        req.setEndpoint(DropBox_ACCESS_TOKEN_URL);
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setBody(requestBody);
        req.setMethod('POST');
        Http http = new Http();
        System.debug('request = '+req);
        System.debug('request body = '+req.getBody());
        HttpResponse res = http.send(req);
      
        System.debug(res.getBody());

        JSONParser parser = JSON.createParser(res.getBody());
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME){
                String fieldName = parser.getCurrentName();
                String fieldValue = parser.getText();   
                if (fieldName == 'access_token') {
                    DropBox_Token = fieldValue; 
                }            
            }
            parser.nextToken();
        }
    }
    
    @AuraEnabled
    public static void createFolderForRecordId(String recordId) {
        System.debug('create folder for '+recordId);
        createFolder(recordId);
    }


    @future(callout=true)
    public static void createFolder(String folderName) {
        setToken();
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
    public static void uploadFiles(String recordId, String JSONfile) {
        File file = (File) System.JSON.deserialize(JSONfile,File.class);
        uploadFile(recordId,file.name,EncodingUtil.base64Decode(file.base64String));    
    }

    @future(callout=true)
    public static void uploadFile(String folderName, String fileName,Blob fileData) {

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
    public static List<String> listFolder(String folderName) {
        System.debug('Inside Listing');
        String dropBoxListingUrl = 'https://api.dropboxapi.com/2/files/list_folder ';
        
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
    public static List<String> FilesListing(String recordId){
        try {
            List<String> fileNames = listFolder(recordId);
            return fileNames; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static void DeleteFile(String folderName , String fileName){
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
    public static String DownloadFile(String folderName , String fileName){
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


//authorization code
// DMrQTPu7MKIAAAAAAAAANNVKvGzSim0kkxDKEwlYs1o



// {"access_token": "sl.ByIsA6Snj9abp3nF6N1IJIihbX8BRDnTjAeyx3R6Np7YbdmF9P3IsPiEgcd69GEQFzbWm8eC10aZC2y3UtS6cXaTvegal7CanQwCyWe7E9jm08pPi7vDkragPqGDqSi5RGZFScbcquoB3m_KK9YN", "token_type": "bearer", "expires_in": 14400, "refresh_token": "Unb0AZw7-ocAAAAAAAAAAcY4_0-PQErfYEzFK7h1UJcgc8ELkGAqlO9b88I87PxR", "scope": "account_info.read account_info.write file_requests.read file_requests.write files.content.read files.content.write files.metadata.read files.metadata.write sharing.read sharing.write", "uid": "1137933091", "account_id": "dbid:AAArLh9AiywGDeF247JJ0QXFdVpVMmieB4k"}


// curl https://api.dropbox.com/oauth2/token \
//    -d refresh_token=<REFRESH TOKEN> \
//    -d grant_type=refresh_token \
//    -d client_id=<APP KEY> \
//    -d client_secret=<APP SECRET>