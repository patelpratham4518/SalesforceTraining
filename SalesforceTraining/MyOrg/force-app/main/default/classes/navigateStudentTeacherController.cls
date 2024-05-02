public without sharing class navigateStudentTeacherController {
    public navigateStudentTeacherController() {

    }

    @AuraEnabled
    public static string navigate(String url){
        try {
            String contactId  = [SELECT ContactId FROM User where Id =: Userinfo.getUserId()limit 1].ContactId;
            String profile = [SELECT Name FROM Profile WHERE Id = : Userinfo.getProfileId() limit 1].Name;
            if (profile == 'StudentLogin') {
                url =  + 'https://mvclouds-c8-dev-ed.develop.my.site.com/s/studentc/'+ [SELECT Id FROM StudentC__c WHERE Contact__c =: contactId limit 1].Id;
            }
            return url;
        } catch (Exception e) {
           
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Subject__c> getSubjects(){
        try {
            String contactId = [SELECT ContactId FROM User WHERE Id =: Userinfo.getUserId() LIMIT 1].ContactId;
            String semesterId = [SELECT  Semester__c FROM StudentC__c WHERE Contact__c =:contactId LIMIT 1].Semester__c;
            List<Subject__c> subjects = [SELECT Id,Name FROM Subject__c WHERE Semester__c =: semesterId];
            return subjects;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}