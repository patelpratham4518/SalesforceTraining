import { LightningElement } from 'lwc';

export default class GetPreviousSite extends LightningElement {
    link = "www.google.com"
    siteAttribute = "visited "+this.link
    goToGoogle(event){
        console.log("inside function");
        sessionStorage.setItem(this.siteAttribute,true)
    }
    

}