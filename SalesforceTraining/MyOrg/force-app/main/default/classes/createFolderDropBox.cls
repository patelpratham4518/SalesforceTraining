@RestResource(urlMapping = '/CreateFolder/')
global  class createFolderDropBox {
    global createFolderDropBox() {

    }

    @HTTPPost
    global static void createFolder(String folderName)() {
        System.debug('REST Folder');
        System.debug('Folder Name = '+folderName);
        RestRequest req = RestContext.request;
        System.debug('req = ',req.toString());
    }


}