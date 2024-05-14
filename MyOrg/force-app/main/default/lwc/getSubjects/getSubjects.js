import { LightningElement, track, wire } from 'lwc';
import getSubjects from '@salesforce/apex/navigateStudentTeacherController.getSubjects'
export default class GetSubjects extends LightningElement {
    subjects
    @wire(getSubjects)setSubject(res){
        this.subjects = res.data
        console.log('subjects ==> ',this.subjects);
    }
    columns = [
        { label: 'Subject', fieldName: 'Name' },
    ]

}