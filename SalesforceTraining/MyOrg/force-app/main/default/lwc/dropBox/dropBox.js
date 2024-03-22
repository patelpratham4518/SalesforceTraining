import { LightningElement, track, wire } from 'lwc';
import { generateUrl } from "lightning/fileDownload";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import  createFolderForRecordId from '@salesforce/apex/DropBox.createFolderForRecordId'
import  uploadFiles from '@salesforce/apex/DropBox.uploadFiles'
import  FilesListing from '@salesforce/apex/DropBox.FilesListing'
import  DeleteFile from '@salesforce/apex/DropBox.DeleteFile'
import  DownloadFile from '@salesforce/apex/DropBox.DownloadFile'

export default class DropBox extends LightningElement {
    recordId
    @track fileNames = []
    @track fileNamesDataTable
    columns = [
        { label: 'File', fieldName: 'fileName'},
        {
            type: "button", label: 'Download', initialWidth: 100, typeAttributes: {
                label: 'Download',
                name: 'Download',
                title: 'Download',
                disabled: false,
                value: 'download',
                iconPosition: 'left',
                iconName:'utility:download',
                variant:'neutral'
            }
        },
        {
            type: "button", label: 'Delete', initialWidth: 110, typeAttributes: {
                label: 'Delete',
                name: 'Delete',
                title: 'Delete',
                disabled: false,
                value: 'delete',
                iconPosition: 'left',
                iconName:'utility:delete',
                variant:'destructive'
            }
        }
    ]

    connectedCallback(){
        this.getRecordId(window.location.href)
        createFolderForRecordId({
            recordId : this.recordId
        })
        this.setData()
    }
    renderedCallback(){

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


            // console.log(jsonFile);
            uploadFiles({
                recordId : this.recordId,
                JSONfile : jsonFile
            }).then((response) => {
                this.showSuccessToast()
                console.log("Uploaded");
                console.log(response);
                this.setData()
             
            }).catch((error)=> {
                console.log("Error : ",error);
            })

            
           
        };
        reader.readAsDataURL(file);
        
    }

    showSuccessToast() {
        try {     
            const evt = new ShowToastEvent({
                title: 'File Uploaded',
                message: 'File Uploaded to dropbox !!!',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
        } catch (error) {
            console.log(error);
        }
        
    }

    setData(){
        FilesListing({
            recordId : this.recordId
        }).then((response)=>{
            this.fileNames = response
            this.fileNamesDataTable = this.fileNames.map((fileName)=>{
                return {fileName : fileName}
            })
        }).catch((error)=>{
            console.log(error);
        })   
    }

    callRowAction(event){
        
        const fileName = event.detail.row.fileName;
        const actionName = event.detail.action.name;
        if (actionName === "Delete") {
            DeleteFile({
                folderName : this.recordId,
                fileName : fileName
            }).then((response)=>{
                this.setData()
            })
        }
        else if (actionName === "Download") {
            DownloadFile({
                folderName : this.recordId,
                fileName : fileName
            }).then((res)=>{
                console.log(res);
                //res is base64String from apex
                // this.downloadFileObject(res, fileName);
                
             
            })
        }
        
    }

    downloadFileObject(base64Data, fileName) {
        // create a Blob from the base64 data
        console.log(fileName);
        const contentType = 'application/octet-stream';
        const byteNumbers = atob(base64Data);
        const byteArray = new Array(byteNumbers.length);
        for (let i = 0; i < byteNumbers.length; i++) {
            byteArray[i] = byteNumbers.charCodeAt(i);
        }
        const blob = new Blob([new Uint8Array(byteArray)], {type: contentType});
    
        // generate a URL for the Blob and initiate the download
        const downloadUrl = generateUrl({
            fileName: fileName,
            contentType: contentType,
            blob: blob
        });
        window.open(downloadUrl);
    }



    
    
    


  

}





    
