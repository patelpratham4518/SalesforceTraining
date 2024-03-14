public with sharing class LWC5 {
    public LWC5() {

    }

    @AuraEnabled
    public static List<Object> getObjectList(String objectType){
        try {
            String query = 'select Id,Name from '+objectType;
            List<Object> objectList = Database.query(query);
            return objectList; 
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static String getEmailId(String objectType,String recordId){
        if (objectType == 'Account') {
            return [select 	Email__c from Account where Id =:recordId].Email__c;
        } else if(objectType == 'Contact'){
            return [select 	Email from Contact where Id =:recordId].Email;
        }else if(objectType == 'Lead'){
            return [select Email from Lead where Id =:recordId].Email;
        }else{
            return null;
        }
    }

    @AuraEnabled
    public static void sendEmail(List<String> emailList , String subject , String message){
        try {
            System.debug('emailList : '+emailList);
            System.debug('subject : '+subject);
            System.debug('message : '+message);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
            
        }
    }
}