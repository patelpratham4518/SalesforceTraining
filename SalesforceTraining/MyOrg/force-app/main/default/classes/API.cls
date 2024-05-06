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
        
    }
    @HttpPut
    global static void doPut() {
        
    }
    @HttpPatch
    global static void doPatch() {
        
    }
}