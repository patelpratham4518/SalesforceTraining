import { LightningElement } from 'lwc';
import  createFolderForRecordId from '@salesforce/apex/DropBox.createFolderForRecordId'
import  uploadFiles from '@salesforce/apex/DropBox.uploadFiles'

export default class DropBox extends LightningElement {
    recordId
    connectedCallback(){
        this.getRecordId(window.location.href)
        createFolderForRecordId({
            recordId : this.recordId
        })
    }
    getRecordId(href){
        this.recordId = href.split("/")[6]
    }
    handleUpload(event){
        console.log("Uploaded");
        
        const file = event.target.files[0];
        file.url = URL.createObjectURL(file)
        const reader = new FileReader();
        reader.onloadend = () => {
            const base64String = reader.result
                .replace('data:', '')
                .replace(/^.+,/, '');
            // console.log("base64 = ",base64String);  
            file.base64String = base64String 
            // console.log(JSON.stringify({
            //     name : file.name,
            //     type : file.type,
            //     base64String : base64String
            // }));
            let jsonFile = JSON.stringify({
                name : file.name,
                type : file.type,
                base64String : base64String
            })
            console.log(jsonFile);
            uploadFiles({
                recordId : this.recordId,
                JSONfile : jsonFile
            }).then((response) => {
                console.log("Uploaded");
            }).catch((error)=> {
                console.log("Error : ",error);
            })
           
        };
        reader.readAsDataURL(file);

        

       

       
        
        
        
    }

}