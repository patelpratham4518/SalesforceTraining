public class DownloadZipController {
    public DownloadZipController() {
        String zipContent = EncodingUtil.urlDecode(ApexPages.currentPage().getParameters().get('zipContent'), 'UTF-8');
        Blob contentBlob = EncodingUtil.base64Decode(zipContent);
        ApexPages.currentPage().getHeaders().put('Content-Disposition', 'attachment; filename=PDFs.zip');
        ApexPages.currentPage().getHeaders().put('Content-Type', 'application/zip');
        ApexPages.currentPage().getHeaders().put('Content-Length', String.valueOf(contentBlob.size()));
    }

    public String zipContent { get; set; }
    
    public PageReference downloadZipFile() {
        zipContent = EncodingUtil.urlDecode(ApexPages.currentPage().getParameters().get('zipContent'), 'UTF-8');
        return null;
    }
}
