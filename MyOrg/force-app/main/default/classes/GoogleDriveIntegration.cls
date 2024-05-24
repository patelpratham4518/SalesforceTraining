public with sharing class GoogleDriveIntegration {
    public GoogleDriveIntegration() {

    }
    public static void getTemplates() {
        List<Template> templatesWithoutBody = getAllDocs();
        List<Template> templates = new List<Template>();
        for ( Template template : templatesWithoutBody) {
            templates.add(getTemplate(template));
        }
        
    }

    public static List<GoogleDriveIntegration.Template> getAllDocs() {
        String endpoint = 'callout:GoogleDrive/files';
        System.debug('Get Templates');

        Map<String, String> params = new Map<String, String>();
        params.put('q','mimeType="application/vnd.openxmlformats-officedocument.wordprocessingml.document"');

        String paramString = '';
        for (String key : params.keySet()) {
            if (!String.isEmpty(paramString)) {
                paramString += '&';
            }
            paramString += EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8');
        }

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + '?'+paramString);
        request.setMethod('GET');
        
        Http http = new Http();
        HttpResponse response = http.send(request);

        // System.debug('Response => '+response);
        // System.debug('Status => '+response.getStatus());
        // System.debug('Body => '+response.getBody());

        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        List<Object> templatesObjects = (List<Object>) responseMap.get('files');
        List<Template> templates = new List<Template>();
        for (Object templateObject : templatesObjects) {
            Template template = (Template) JSON.deserialize(JSON.serialize(templateObject),Template.class);
            templates.add(template);
        }
        return templates;
    }

    public static GoogleDriveIntegration.Template getTemplate(Template template) {
        System.debug('Get Template');
        String endpoint = 'callout:GoogleDrive/files/'+template.id;

        Map<String, String> params = new Map<String, String>();
        params.put('alt','media');

        String paramString = '';
        for (String key : params.keySet()) {
            if (!String.isEmpty(paramString)) {
                paramString += '&';
            }
            paramString += EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8');
        }

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + '?'+paramString);
        request.setMethod('GET');
        
        Http http = new Http();
        HttpResponse response = http.send(request);

        System.debug('Response => '+response);
        System.debug('Status => '+response.getStatus());
        System.debug('Body => '+response.getBody());

        template.body = response.getBodyAsBlob();
        return template;
    }

    public class Template{
        public String id;
        public String name;
        public Blob body;
    }




    
}