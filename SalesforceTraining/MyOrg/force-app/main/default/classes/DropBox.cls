public with sharing class DropBox {
    public DropBox() {

    }

    @AuraEnabled
    public static void createFolderForRecordId(String recordId) {
        System.debug('create folder for '+recordId);
    }

    @AuraEnabled
    public static void uploadFiles(String recordId, String JSONfile) {
        
        File file = (File) System.JSON.deserialize(JSONfile,File.class);
        
    }

    public class File {
        public String name;
        public String type;
        public String base64String;
    }
}