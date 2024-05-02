public class GeneratePDFController {
    public String pdfContent { get; set; }

    
    public GeneratePDFController() {
        pdfContent = EncodingUtil.urlDecode(ApexPages.currentPage().getParameters().get('pdfContent'), 'UTF-8');
        
    }
}