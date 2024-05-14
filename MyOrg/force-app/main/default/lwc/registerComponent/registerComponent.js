import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import checkUserNameAvailability from '@salesforce/apex/CommunityAuthController.checkUserNameAvailability'
import register from '@salesforce/apex/CommunityAuthController.register'

export default class RegisterComponent extends LightningElement {
    value = '';
    Gender = '';
    FirstName = ''
    LastName = ''
    Email = ''
    UserName = ''
    @track password = ''
    @track isUserNameAvailable = null
    @track isStudent = false
    @track isTeacher = false
    get options() {
        return [
            { label: 'Student', value: 'Student' },
            { label: 'Teacher', value: 'Teacher' },
        ];
    }
    get genders() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
            { label: 'Others', value: 'Others' }
        ];
    }
    handleChange(event){
        this.value = event.target.value
        if (this.value === "Student") {
            this.isStudent = true
            this.isTeacher = false
        }else if (this.value === "Teacher") {
            this.isTeacher = true
            this.isStudent = false
        }
    }

    setGender(event){
        this.Gender = event.target.value
    }

    setFirstName(event){
        this.FirstName = event.target.value
    }
    setLastName(event){
        this.LastName = event.target.value
    }
    setEmail(event){
        this.Email =  event.target.value
    }
    setUserName(event){
        this.UserName = event.target.value
        if (this.isUserNameAvailable == true) {
            this.isUserNameAvailable = false
        }
    }
    checkUserName(){
        checkUserNameAvailability({
            userName : this.UserName 
        }).then((response) => {
           this.isUserNameAvailable = response
        }).catch((error)=>{
            console.log(error);
        })
    }
    setPassword(event){
        this.password = event.target.value
    }
    register(){
        console.log("regester now");
        if (this.checkPassword()) {
            register({
                profile : this.value,
                firstName : this.FirstName,
                lastName : this.LastName,
                gender : this.Gender,
                emailAddress : this.Email,
                userName : this.UserName,
                password : this.password
            }).then((res)=>{
                console.log(res);
                // showSuccessToast()
                window.location.replace("https://mvclouds-c8-dev-ed.develop.my.site.com/s/login/");
                console.log(res);
            }).catch(err=>{
                console.log(err);
            })
        }
    }

    checkPassword(){
        if (this.password.length < 8) {
            alert('Password must be at least 8 characters')
            this.password = ""
            return false
        }else if (this.password.search(/[a-z]/) < 0) {
            alert('Password must contain at least one lowercase letter')
            this.password = ""
            return false
        }else if (this.password.search(/[A-Z]/) < 0) {
            alert('Password must contain at least one uppercase letter')   
            this.password = ""
            return false
        }else if (this.password.search(/[0-9]/) < 0) {
            alert('Password must contain at least one number')
            this.password = ""
            return false
        }else{
            return true
        }
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Success',
            message: 'Registered Succesfully',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

}