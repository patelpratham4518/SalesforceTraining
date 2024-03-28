@RESTResource(urlMapping='/myOrg/object')
global with sharing class SalesforceAPI {
    @HTTPPost
    global static String postMethod() {
        System.debug('SalesforceAPI');
        String objectName,noOfRecords;
        List<String> fields = new List<String>();
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string requestBody = req.requestBody.toString();
        System.debug(requestBody);
        JSONParser parser = JSON.createParser(requestBody);
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
                String fieldName = parser.getCurrentName();
                parser.nextToken();
                String fieldValue = parser.getText();
                if (fieldName == 'object') {
                   objectName = fieldValue;
                }else if (fieldName == 'limit') {
                    noOfRecords = fieldValue;
                }
                else if (fieldName == 'fields') {
                    for (String field : fieldValue.split(',')) {
                        fields.add(field);
                    }
                }
                
                
            }   
        }
        String queryString = 'SELECT '+ String.join(fields,',')+' from '+objectName+' LIMIT '+noOfRecords;
        try {
            String response = JSON.serialize(Database.query(queryString));
            System.debug(Database.query(queryString));
            return response;
        } catch (Exception e) {
            return e.getMessage();
        }
    }
}


