public class ContentDownloadHandlerFactoryImpl implements Sfc.ContentDownloadHandlerFactory {

    public Sfc.ContentDownloadHandler getContentDownloadHandler( List<ID> listIds, Sfc.ContentDownloadContext context ) {
    
        Sfc.ContentDownloadHandler contentDownloadHandler = new Sfc.ContentDownloadHandler();
        
        system.debug( 'Inside the Content Download' );     
        Id profileId = UserInfo.getProfileId();
        Profile objProfile = [ SELECT Id, Name FROM Profile WHERE Id =: profileId ];

        for (Id id : listIds) {
            String fileName ;
            List<ContentVersion> contentVersion = [SELECT Title FROM ContentVersion WHERE Id = :id LIMIT 1];
            List<Attachment> attachment = [SELECT Name from Attachment where Id=:id];
            if (contentVersion.size()>0) {
                fileName = contentVersion[0].Title;
            }else if (attachment.size()>0) {
                fileName = attachment[0].Name;
            }
            System.debug(fileName);
            if( String.isNotBlank( profileId ) ) {
                
                
                if ( objProfile != null && objProfile.Name == 'System Administrator' && (fileName == 'licence' || fileName == 'ImgAttachment') ) {
                
                    contentDownloadHandler.isDownloadAllowed = false;
                    contentDownloadHandler.downloadErrorMessage = 'Downloading a file is not allowed for your profile';
                    return contentDownloadHandler;
                }
            }
        }
        
        contentDownloadHandler.isDownloadAllowed = true;
        return contentDownloadHandler;
    
    }

}