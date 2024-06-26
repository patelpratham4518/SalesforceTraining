@RESTResource(urlMapping='/myOrg/object')
global with sharing class SalesforceAPI {
    @HTTPPost
    global static void postMethod() {
        System.debug('SalesforceAPI POST');
        String objectName,noOfRecords;
        List<String> fields = new List<String>();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String requestBody = req.params.toString();
        
        objectName = req.params.get('object'); 
        noOfRecords = req.params.get('limit');
        fields = req.params.get('fields').split(',');
        
        // String requestBody = req.requestBody.toString();
        
        // JSONParser parser = JSON.createParser(requestBody);
     
        // while (parser.nextToken()!=null) {
         
        //     if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
        //         parser.nextToken();
        //         String fieldName = parser.getCurrentName();
        //         String fieldValue = parser.getText();
        //         System.debug(fieldName + ' : '+ fieldValue);
        //         if (fieldName == 'object') {
        //             objectName = fieldValue;
        //          }else if (fieldName == 'limit') {
        //              noOfRecords = fieldValue;
        //          }
        //          else if (fieldName == 'fields') {
        //              for (String field : fieldValue.split(',')) {
        //                  fields.add(field);
        //              }
        //          }
                
        //     }
        // }
        
        // while (parser.nextToken() != null) {
        //     if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
        //         parser.nextToken();
        //         String fieldName = parser.getCurrentName();
        //         String fieldValue = parser.getText();
        //         if (fieldName == 'object') {
        //            objectName = fieldValue;
        //         }else if (fieldName == 'limit') {
        //             noOfRecords = fieldValue;
        //         }
        //         else if (fieldName == 'fields') {
        //             for (String field : fieldValue.split(',')) {
        //                 fields.add(field);
        //             }
        //         }
                
                
        //     }   
        // }
        String queryString = 'SELECT '+ String.join(fields,',')+' from '+objectName+' LIMIT '+noOfRecords;
        System.debug(queryString);
        try {
            String response = JSON.serialize(Database.query(queryString));
            res.addHeader('Content-Type', 'application/json');
            res.responseBody = Blob.valueOf(response);
            res.statusCode = 200;
            // return response;
        } catch (Exception e) {
            // return e.getMessage();
            res.StatusCode = 400;
            res.addHeader('Content-Type', 'text/plain');
            res.responseBody = Blob.valueOf(e.getMessage());

        }
    }

    @HTTPGet
    global static void getMethod() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        try {
            System.debug('GET method');
            System.debug(req.headers);
            String objectName = req.headers.get('Object');
            String id = req.headers.get('Id');
            List<String> fields = req.headers.get('fields').split(',');

            System.debug(objectName);
            System.debug(id);
            System.debug(fields);
            
            String queryString = 'SELECT '+ String.join(fields,',')+' from '+objectName+' where Id =:id';
            Object record = Database.query(queryString);
            System.debug(record);
            res.addHeader('Content-Type', 'application/json');
            res.responseBody = Blob.valueOf(JSON.serialize(record));
            res.statusCode = 200;
            
        } catch (Exception e) {
            System.debug(e.getMessage());
            res.StatusCode = 400;
            res.addHeader('Content-Type', 'text/plain');
            res.responseBody = Blob.valueOf(e.getMessage());
        }
    }
}

