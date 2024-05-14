import { LightningElement, wire} from 'lwc';
import 	TeacherHelp from '@salesforce/label/c.TeacherHelp';
import 	StudentHelp from '@salesforce/label/c.StudentHelp';
import { getRecord } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import PROFILE_NAME_FIELD from '@salesforce/schema/User.Profile.Name';


export default class HelpLWC extends LightningElement {
    helpcontent;
    profileName;
    userId = USER_ID; 

    @wire(getRecord, { recordId: USER_ID, fields: [PROFILE_NAME_FIELD] })
    wiredUser({ error, data }) {
        if (data) {
            
            this.profileName = data.fields.Profile.displayValue;
            if (this.profileName == 'StudentLogin') {
                this.helpcontent = StudentHelp
            }else if (this.profileName == 'TeacherLogin') {
                this.helpcontent = TeacherHelp
            }
        } else if (error) {
            console.error('Error fetching user profile name:', error);
        }
    }
}
