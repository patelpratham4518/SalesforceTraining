public class FileUploadController {
    public String Type { get; set; }
    public String fileName { get; set; }
    public transient  blob file { get; set; }
    public String title{ get;set; }
    public ContentVersion cv { get; set; }
    // String contactId = System.currentPagereference().getParameters().get('Id');
    public FileUploadController(ApexPages.StandardController controller) {
    }
    
    public PageReference upload() {
        ContentVersion cv = new ContentVersion();
        cv.versionData = file;
        cv.title = title;
        cv.pathOnClient = fileName;

        Contact contact = new Contact(LastName = 'guestusercreatedfromsite');
        insert contact;
        // cv.OwnerId = contact.Id;
        // cv.FirstPublishLocationId = contact.Id;

        cv.OwnerId = '005H3000000KsMwIAK';
        cv.FirstPublishLocationId = '003H3000003lUFaIAM';
        try
        {
            Insert cv;
        }
        catch (DMLException e)
        {
            System.debug(e.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
            return null;
        }
        catch (Exception e)
        {
            System.debug(e.getMessage());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
        }
        finally
        {
            cv = new ContentVersion();
        }
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Document uploaded successfully to library'));
        return null;
    }
}