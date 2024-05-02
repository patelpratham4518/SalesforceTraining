import { LightningElement } from 'lwc';
import resetPassword from '@salesforce/apex/CommunityAuthController.resetPassword';

export default class CommunityForgotPassword extends LightningElement {
    username
    setUsername(event){
        this.username = event.target.value
    }
    reset(){
        resetPassword({
            username : this.username
        }).then(result => {
            console.log('result of reset',result)
            window.location.href = 'https://mvclouds-c8-dev-ed.develop.my.site.com/s/login/CheckPasswordResetEmail'
        }).catch(error => {
            console.log(error)
        })
    }
}