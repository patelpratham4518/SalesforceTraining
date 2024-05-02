import { LightningElement } from 'lwc';
import navigate from '@salesforce/apex/navigateStudentTeacherController.navigate'

export default class NavigateStudentTeacher extends LightningElement {
    connectedCallback(){
        console.log('Inside navigate');
        navigate({
            url : window.location.href
        }).then((url) => {
            console.log('url ==> ',url);
            window.location.replace(url)
        }).catch((error) => {
            console.log(error)
        })
    }
}