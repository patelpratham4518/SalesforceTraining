import { LightningElement } from 'lwc';


export default class LWC2 extends LightningElement {
    imageUrl = "https://source.unsplash.com/random"
    handleUploadFinished(event) { 
        // Get the list of uploaded files 
        console.log("Finished upload called");
        let image = this.template.querySelector('[data-id="image"]').files[0]
        this.imageUrl = URL.createObjectURL(image)
        
    }
}