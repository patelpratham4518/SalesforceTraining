public class ZipUtil {
    public static Blob createZip(List<DownloadPDFController.ZipEntry> zipEntries) {
        Blob zipBlob;
        try {
            // Create zip file
            // Implement the logic to create a zip file from the provided zipEntries
        } catch(Exception e) {
            // Handle error
            System.debug('Error creating zip file: ' + e.getMessage());
            zipBlob = Blob.valueOf('');
        }
        return zipBlob;
    }
}
