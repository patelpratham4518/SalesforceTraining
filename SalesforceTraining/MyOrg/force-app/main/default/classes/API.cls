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
        System.debug('Type of Params'+request.params);
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