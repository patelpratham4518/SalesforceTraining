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

      
    }

}