@RestResource(urlMapping = '/API/')
global without sharing class API {
    public API() {
        
    }

    @HttpGet
    global static void doGet() {
        System.debug('Get Method');
        RestRequest request  = RestContext.request;
        RestResponse response = RestContext.response;

        System.debug('Request ==>'+request);

        String objectName = request.params.get('object');
        List<String> fields = request.params.get('fields').split(',');
        String queryString = 'SELECT '+String.join(fields,',')+' FROM '+objectName;
        
        if(request.params.containsKey('Id') == True) {
            String id = request.params.get('Id');
            queryString += ' WHERE Id=:id';
        }else  if (request.params.containsKey('limit') == True) {
            String noOfRecords = request.params.get('limit');
            queryString += ' LIMIT '+noOfRecords;
        }

        System.debug('query ==>'+ queryString);
        try {
            response.responseBody = Blob.valueOf(JSON.serialize(Database.query(queryString))); 
            response.addHeader('Content-Type','application/json');
            response.statusCode = 200;

        } catch (Exception e) {
            System.debug(e.getMessage());
            response.responseBody = Blob.valueOf(e.getMessage());
            response.addHeader('Content-Type','text/plain');
            response.statusCode = 400;
        }
    }

    @HttpPost
    global static void doPost() {

        System.debug('Post Method');
        RestRequest request  = RestContext.request;
        RestResponse response = RestContext.response;
        System.debug('Request ==>'+request);
        System.debug('Request Body '+(request.requestBody).toString());
        Map<String, Object> requestMap = (Map<String, Object>)JSON.deserializeUntyped((request.requestBody).toString());
        Map<String, Object> fieldsMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(requestMap.get('fields')));
        
        try {
            String objectName = (String) requestMap.get('object');
            SObject sObjectInstance = Schema.getGlobalDescribe().get(objectName).newSObject();
            for(String field : fieldsMap.keySet()) {
                Object fieldValue = fieldsMap.get(field);
                sObjectInstance.put(field,fieldValue);
            }
            insert sObjectInstance;
            response.statusCode = 201; // Created
            response.responseBody = Blob.valueOf('SObject created successfully.');
        } catch (Exception e) {
            System.debug('Error ==> '+ e.getMessage());
            response.statusCode = 500; // Internal Server Error
            response.responseBody = Blob.valueOf('An error occurred: ' + e.getMessage());
        }
        
    }
    @HttpDelete
    global static void doDelete() {
        System.debug('Delete Method');
        RestRequest request  = RestContext.request;
        RestResponse response = RestContext.response;
        System.debug('Request ==>'+request);
        try {
            
            String objectName = request.params.get('object');
            String id = request.params.get('Id');
            SObject sObjectInstance = Schema.getGlobalDescribe().get(objectName).newSObject();
            sObjectInstance.Id = id;
            delete sObjectInstance;
            response.statusCode = 200; 
            response.responseBody = Blob.valueOf('Object deleted succesfully');

        } catch (Exception e) {
            System.debug('Error ==> ' + e.getMessage());
            response.statusCode = 400; // Bad request if there was an error
            response.responseBody = Blob.valueOf('An error occurred: ' + e.getMessage());
        }
        
    }
 
    @HttpPut
    global static void doPut() {
        System.debug('Put Method');
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        System.debug('Request ==>' + request);
        System.debug('Request Body ' + request.requestBody.toString());
        
        try {
            Map<String, Object> requestMap = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
            Map<String, object> fieldsMap = (Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(requestMap.get('fields')));
            
            String objectName = (String)requestMap.get('object');
            SObject sObjectInstance = Schema.getGlobalDescribe().get(objectName).newSObject();
            for(String field : fieldsMap.keySet()) {
                Object fieldValue = fieldsMap.get(field);
                sObjectInstance.put(field,fieldValue);
            }
            upsert sObjectInstance;
            response.statusCode = 200;
            response.responseBody = Blob.valueOf('Record upserted successfully.');
            
        } catch (Exception e) {
            System.debug('Error ==> ' + e.getMessage());
            response.statusCode = 400;
            response.responseBody = Blob.valueOf('An error occurred: ' + e.getMessage());
        }
    }

    @HttpPatch
    global static void doPatch() {
        System.debug('Patch Method');
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        System.debug('Request ==>' + request);
        System.debug('Request Body ' + request.requestBody.toString());
        
        try {
            Map<String, Object> requestMap = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
            
            
            String objectName = request.params.get('object');
            String recordId = request.params.get('Id');
            String queryString = 'SELECT Id FROM '+objectName+ ' WHERE Id=:recordId LIMIT 1';

            SObject sObjectInstance = Database.query(queryString);
            
            if (sObjectInstance == null) {
                response.statusCode = 404;
                response.responseBody = Blob.valueOf('Record not found.');
                return;
            }
            Map<String, Object> fieldsMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(requestMap.get('fields')));
            System.debug('fieldsmap ==> '+ fieldsMap);
            System.debug('fieldsMap ==> '+fieldsMap);
            for (String fieldName : fieldsMap.keySet()) {
                Object fieldValue = fieldsMap.get(fieldName);
                sObjectInstance.put(fieldName, fieldValue);
            }
            
            update sObjectInstance;
            
            response.statusCode = 200;
            response.responseBody = Blob.valueOf('Record updated successfully.');
            
        } catch (Exception e) {
            System.debug('Error ==> ' + e.getMessage());
            System.debug('Trace ==> '+ e.getStackTraceString());
            response.statusCode = 400;
            response.responseBody = Blob.valueOf('An error occurred: ' + e.getMessage());
        }

    }
}