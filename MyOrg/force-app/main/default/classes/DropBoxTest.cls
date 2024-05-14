@isTest
private class DropBoxTest{
    public class ExampleCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){
            HttpResponse res = new HttpResponse();
            String endPoint = req.getEndpoint();
            if (endPoint == 'https://api.dropbox.com/oauth2/token') {
                res.setBody('{"access_token": "sl.BynhCQJJ8cSuGpLh1VO9mI-us6AwoYZNRaoATrWOtVox2KiTwI1fajNv2JQDJESRVTZPR4eSvMsSjT9FnWhu-RvDjNoJQjGPDiopSoM9YB8mESkN_0FpO_Zc4VTV2AqjxbezDTOGwTMlrs8BTTHl","token_type": "bearer","expires_in": 14400}');
                res.setStatus('OK');
                res.setStatusCode(200);
            }else if (endPoint == 'https://api.dropboxapi.com/2/files/create_folder_v2' ) {
                res.setBody('folder created');
                res.setStatus('OK');
                res.setStatusCode(200);
            }else if (endPoint == 'https://content.dropboxapi.com/2/files/upload') {
                res.setBody('file uploaded');
                res.setStatus('OK');
                res.setStatusCode(200);
            }else if (endPoint == 'https://api.dropboxapi.com/2/files/list_folder') {
                res.setBody('{"entries":[{"name":"Stairway to Heaven.jpeg"},{"name":"Taxi Car School Driving.jpeg"},{"name":"lord god shiva.jpeg"}]}');
                res.setStatus('OK');
                res.setStatusCode(200);
            }else if (endPoint == 'https://api.dropboxapi.com/2/files/delete_v2') {
                res.setBody('File deleted');
                res.setStatus('OK');
                res.setStatusCode(200);
            }else if (endPoint == 'https://content.dropboxapi.com/2/files/download') {
                res.setBody('File download');
                res.setStatus('OK');
                res.setStatusCode(200);
            }
            return res;
        }
    }

    @isTest
    static void setToken() {
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        String access_token = DropBox.setToken();
        System.debug(access_token); 
        Assert.isNotNull(access_token);
        Test.stopTest();
    }

    @IsTest
    static void createFolderForRecordId(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        DropBox.createFolderForRecordId('0035g00001CbegNAAR','sl.BynhCQJJ8cSuGpLh1VO9mI-us6AwoYZNRaoATrWOtVox2KiTwI1fajNv2JQDJESRVTZPR4eSvMsSjT9FnWhu-RvDjNoJQjGPDiopSoM9YB8mESkN_0FpO_Zc4VTV2AqjxbezDTOGwTMlrs8BTTHl');
        Test.stopTest();
    }

    @IsTest
    static void uploadFiles(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        DropBox.uploadFiles('0035g00001CbegNAAR','{"name":"lord god shiva.jpeg","type":"image/jpeg","base64String":"base64string"}','sl.BynhCQJJ8cSuGpLh1VO9mI-us6AwoYZNRaoATrWOtVox2KiTwI1fajNv2JQDJESRVTZPR4eSvMsSjT9FnWhu-RvDjNoJQjGPDiopSoM9YB8mESkN_0FpO_Zc4VTV2AqjxbezDTOGwTMlrs8BTTHl');
        Test.stopTest();
    }

    @IsTest
    static void FilesListing(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        List<String> listing = DropBox.FilesListing('0035g00001CbegNAAR','sl.BynhCQJJ8cSuGpLh1VO9mI-us6AwoYZNRaoATrWOtVox2KiTwI1fajNv2JQDJESRVTZPR4eSvMsSjT9FnWhu-RvDjNoJQjGPDiopSoM9YB8mESkN_0FpO_Zc4VTV2AqjxbezDTOGwTMlrs8BTTHl');
        Assert.areEqual(listing.size(),3);
        Test.stopTest();
    }

    @IsTest
    static void DeleteFile(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        DropBox.DeleteFile('0035g00001CbegNAAR','lord god shiva.jpeg','sl.BynhCQJJ8cSuGpLh1VO9mI-us6AwoYZNRaoATrWOtVox2KiTwI1fajNv2JQDJESRVTZPR4eSvMsSjT9FnWhu-RvDjNoJQjGPDiopSoM9YB8mESkN_0FpO_Zc4VTV2AqjxbezDTOGwTMlrs8BTTHl');
        Test.stopTest();
    }

    @IsTest
    static void DownloadFile(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        DropBox.DownloadFile('0035g00001CbegNAAR','lord god shiva.jpeg','sl.BynhCQJJ8cSuGpLh1VO9mI-us6AwoYZNRaoATrWOtVox2KiTwI1fajNv2JQDJESRVTZPR4eSvMsSjT9FnWhu-RvDjNoJQjGPDiopSoM9YB8mESkN_0FpO_Zc4VTV2AqjxbezDTOGwTMlrs8BTTHl');
        Test.stopTest();
    }


}