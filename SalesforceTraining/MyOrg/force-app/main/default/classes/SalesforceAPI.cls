@RESTResource(urlMapping='/myOrg/')
global with sharing class SalesforceAPI {
    @HTTPPost
    global static String postMethod() {
        System.debug('SalesforceAPI');
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        string requestBody = req.requestBody.toString();
        System.debug(requestBody);
        JSONParser parser = JSON.createParser(requestBody);
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() != JSONToken.END_OBJECT) {
                String fieldName = parser.getCurrentName();
                String fieldValue = parser.getText();
                System.debug('FieldName = '+fieldName);
                System.debug('FieldValue = '+fieldValue);
            }
        }
        return 'salesforceAPI called';
    }
}