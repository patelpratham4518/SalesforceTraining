public with sharing class DownloadPDFController {
    public static String downloadLink {get;set;}
    

    public DownloadPDFController(ApexPages.StandardController sc) {

    }

    

    public static PageReference downloadPDF() {

            // Generate PDF content
            List<PageReference> pdfList = new List<PageReference>();
            Map<String, Blob> pdfMap = new Map<String, Blob>();
            for (Integer i = 1; i <= 10; i++) {
                String pdfContent = 'This is PDF ' + i;
                PageReference pdfPage = new PageReference('/apex/generatePDF');
                pdfPage.getParameters().put('pdfContent', EncodingUtil.urlEncode(pdfContent, 'UTF-8'));
                pdfPage.getParameters().put('pdfName', 'pdf' + i + '.pdf');
                pdfList.add(pdfPage);
                pdfMap.put('pdf'+i,pdfPage.getContentAsPDF());
            }
            Blob zipFileBlob  = getZip(pdfMap);
            Attachment attachment = new Attachment(Name = 'pdfZip.zip',Body = zipFileBlob,ParentId = [SELECT Id from Account where Name = 'Assesment' limit 1].Id);
            insert attachment;

            // String pdfContent = 'This is PDF ' + '1';
            // PageReference pdfPage = new PageReference('/apex/generatePDF');
            // pdfPage.getParameters().put('pdfContent', EncodingUtil.urlEncode(pdfContent, 'UTF-8'));
            // pdfPage.getParameters().put('pdfName', 'pdf' + '1' + '.pdf');

            // Blob pdfBlob = pdfPage.getContentAsPDF(); 


            // ApexPages.currentPage().getHeaders().put('Content-Disposition', 'attachment; filename=pdf1.pdf');
            // ApexPages.currentPage().getHeaders().put('Content-Length', String.valueOf(pdfBlob.size()));
            // ApexPages.currentPage().getHeaders().put('Content-Type', 'application/pdf');
            // ApexPages.currentPage().getParameters().put('pdfContent',EncodingUtil.base64Encode(pdfBlob));

            return null;     
    }




    public static Blob getZip(Map<String,Blob> pdfMap) {
        Blob zipFileBlob;

        Zippex pdfZip = new Zippex();

        for(String name : pdfMap.keySet()) {
            Blob pdf = pdfMap.get(name);
            pdfZip.addFile(name,pdf,null);
        }
        zipFileBlob = pdfZip.getZipArchive();
        return zipFileBlob;
    }






    @InvocableMethod(label = 'Download PDF')
    public static void downloadPDFFlow() {

            // Generate PDF content

            String pdfContent = 'This is PDF ' + '1';
            PageReference pdfPage = new PageReference('/apex/generatePDF');
            pdfPage.getParameters().put('pdfContent', EncodingUtil.urlEncode(pdfContent, 'UTF-8'));
            pdfPage.getParameters().put('pdfName', 'pdf' + '1' + '.pdf');
            Blob pdfBlob = pdfPage.getContentAsPDF();
            
    }



    
}