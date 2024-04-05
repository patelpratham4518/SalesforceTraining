@RestResource(urlMapping='/getPdf')
global with sharing class DownloadPDFRest {
 @HTTPGet
 global static void getPDF(){
    RestRequest req = RestContext.request;       
    RestResponse res = RestContext.response; 
                // Generate PDF content
                String pdfContent = 'This is PDF ' + '1';
                PageReference pdfPage = new PageReference('/apex/generatePDF');
                pdfPage.getParameters().put('pdfContent', EncodingUtil.urlEncode(pdfContent, 'UTF-8'));
                pdfPage.getParameters().put('pdfName', 'pdf' + '1' + '.pdf');
                Blob pdfBlob = pdfPage.getContentAsPDF();
    res.addHeader('Content-Disposition','attachment; filename="' + pdfPage.getParameters().get('pdfName')+'"');
    res.addHeader('Content-Length',String.valueOf(pdfBlob.size()));
    res.addHeader('Content-Type', 'application/pdf');

    res.responseBody =pdfBlob ;
    res.statusCode = 200;
 }
}