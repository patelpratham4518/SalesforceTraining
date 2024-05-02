import { LightningElement } from 'lwc';
import doLogin from '@salesforce/apex/CommunityAuthController.doLogin';

export default class CommunityLoginLWC extends LightningElement {
    username;
    password;
    setUsername(event){
        this.username = event.target.value
    }
    setPassword(event){
        this.password = event.target.value
    }

    login(){
        doLogin({
            username : this.username,
            password : this.password
        }).then((res)=>{
            console.log('Response => ',res);
            window.location.replace(res)
        }).catch((err)=>{
            console.log('error => ',err);
        })
    }

}