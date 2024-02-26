
@isTest
private class addFileToOpportunityTestClass {
    
    public class ExampleCalloutMock implements HttpCalloutMock{
        public HttpResponse respond(HTTPRequest req){

            // HTTPResponse res = new Http().send(req);
            // return res;

            if (req.getEndpoint() == 'https://source.unsplash.com/random') {                
                HttpResponse res = new HttpResponse();
                res.setBody('<html><body>You are being <a href="https://plus.unsplash.com/premium_photo-1664099905183-56c6f1aa4a91?crop=entropy&amp;cs=tinysrgb&amp;fit=max&amp;fm=jpg&amp;ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTcwODkzOTY5OQ&amp;ixlib=rb-4.0.3&amp;q=80&amp;w=1080">redirected</a>.</body></html>');
                return res;
            }
            else {
                HttpResponse res = new HttpResponse();
                res.setBody('/9j/4AAQSkZJRgABAgEASABIAAD/4gxYSUNDX1BST0ZJTEUAAQEAAAxITGlubwIQAABtbnRyUkdCIFhZWiAHzgACAAkABgAxAABhY3NwTVNGVAAAAABJRUMgc1JHQgAAAAAAAAAAAAAAAAAA9tYAAQAAAADTLUhQICAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFjcHJ0AAABUAAAADNkZXNjAAABhAAAAGx3dHB0AAAB8AAAABRia3B0AAACBAAAABRyWFlaAAACGAAAABRnWFlaAAACLAAAABRiWFlaAAACQAAAABRkbW5kAAACVAAAAHBkbWRkAAACxAAAAIh2dWVkAAADTAAAAIZ2aWV3AAAD1AAAACRsdW1pAAAD+AAAABRtZWFzAAAEDAAAACR0ZWNoAAAEMAAAAAxyVFJDAAAEPAAACAxnVFJDAAAEPAAACAxiVFJDAAAE');
                return res;
            }
          
        }
    }

    @isTest
    static void futureAttach() {
        Opportunity opportunity = new Opportunity(Name = 'TestOppo', CloseDate = Date.today() , StageName = 'Prospecting');
        Test.startTest();
        insert opportunity;
        Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());
        addFileToOpportunity.futureAttach('','',opportunity.Id);
        Test.stopTest();
        Integer count = [select count() from Attachment where parentId =:opportunity.Id];   
        System.debug('Count='+count);  
        Assert.areEqual(1,count);   
    }
}