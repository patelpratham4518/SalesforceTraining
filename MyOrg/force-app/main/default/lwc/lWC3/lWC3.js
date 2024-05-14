import { LightningElement, track } from 'lwc';

export default class LWC3 extends LightningElement {
    attachCount = 0
   @track attachmentList = []
    handleChange(event){
        console.log("handleChange called");
        // let attachments = this.template.querySelector('[data-id="attachments"]').files[0]
        // attachments.index = this.attachCount++
        // attachments.url = URL.createObjectURL(attachments)
        // this.attachmentList.push(attachments)

        let attachments = this.template.querySelector('[data-id="attachments"]').files
        for (let attach of attachments) {
            attach.index = this.attachCount++
            attach.url = URL.createObjectURL(attach)
            this.attachmentList.push(attach)
        }
        
        this.totalPages = Math.ceil(this.attachmentList.length/this.recordsPerPage)
        this.preparePaginationList()
    }


     currentPage = 1
     pageList = []
     recordsPerPage = 10
     totalPages = 1

    handleNext() {
        if (this.currentPage < this.totalPages) {     
            this.currentPage += 1;
            this.preparePaginationList();
        }
    }

    handlePrevious() {
        if (this.currentPage > 1) {
            this.currentPage -= 1;
            this.preparePaginationList();
        }
    }

    handleFirst() {
        this.currentPage = 1;
        this.preparePaginationList();
    }

    handleLast() {
        this.currentPage = this.totalPages;
        this.preparePaginationList();
    }

    preparePaginationList(){
        let begin = (this.currentPage-1)*(this.recordsPerPage)
        let end  = begin + this.recordsPerPage
        this.pageList = this.attachmentList.slice(begin,end)
        console.log("currentPage",this.currentPage);
        console.log("recordsPerPage",this.recordsPerPage);
        console.log("totalPages",this.totalPages);
        console.log("begin",begin);
        console.log("end",end);

    }

    changeRecordsPerPage(event){
        
        this.recordsPerPage = Number(event.target.value)
        this.totalPages = Math.ceil(this.attachmentList.length/this.recordsPerPage)
        this.currentPage = 1
        this.preparePaginationList()
    }

}