public with sharing class DownloadPDFController {
    public static String downloadLink {get;set;}
    public static Integer pdfListSize {get;set;}
    public static Map<String, Blob> pdfMap = new Map<String, Blob>();
    

    public DownloadPDFController(ApexPages.StandardController sc) {

    }

    

    public static PageReference downloadPDF() {

            // Generate PDF content
            List<PageReference> pdfList = new List<PageReference>();
            for (Integer i = 1; i <= 2; i++) {
                String pdfContent = 'This is PDF ' + i;
                PageReference pdfPage = new PageReference('/apex/generatePDF');
                pdfPage.getParameters().put('pdfContent', EncodingUtil.urlEncode(pdfContent, 'UTF-8'));
                pdfPage.getParameters().put('pdfName', 'pdf' + i + '.pdf');
                pdfList.add(pdfPage);
                pdfMap.put('pdf'+i,pdfPage.getContentAsPDF());
            }
            Blob zipFileBlob  = getZip(pdfMap);
            downloadLink = EncodingUtil.base64Encode(zipFileBlob);
            pdfListSize = pdfList.size();
            System.debug('Size of pdf list ===> '+pdfList.size());
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

    @RemoteAction public static List<Blob> sendpdfMap(){
        List<PageReference> pdfList = new List<PageReference>();
        List<Blob> pdfBlobList = new List<Blob>();
        for (Integer i = 1; i <= 5; i++) {
            String pdfContent = 'This is PDF ' + i;
            PageReference pdfPage = new PageReference('/apex/generatePDF');
            pdfPage.getParameters().put('pdfContent', EncodingUtil.urlEncode(pdfContent, 'UTF-8'));
            pdfPage.getParameters().put('pdfName', 'pdf' + i + '.pdf');

            pdfBlobList.add(pdfPage.getContentAsPDF());
        }

        return pdfBlobList;
    }










    
}