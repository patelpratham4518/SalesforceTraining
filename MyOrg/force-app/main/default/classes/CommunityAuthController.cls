global without sharing class CommunityAuthController {
    global CommunityAuthController() {

    }
    @AuraEnabled
    global static Boolean checkUserNameAvailability(String userName) {
        List<User> users = [select Username from User];
        for (User user : users) {
            if (user.UserName == userName) {
                return false;
            }
        }
        return true;
    }
    
    @AuraEnabled
    global static string register(String profile,String firstName, String lastName,String gender, String emailAddress,String userName,String password){
        try {
            String communityNickname = '';
            Set<String> communityNicknameSet = new Set<String>();

            for(User usr : [Select Id, CommunityNickname From User Where CommunityNickname != null]){

                communityNicknameSet.add(usr.CommunityNickname);
            }
            if (communityNicknameSet.contains(firstName+lastName)) {
                communityNickname = firstName+lastName;
            }else {
                communityNickname = userName;
            }
            

            Account account = new Account(Name = firstName+lastName, Gender__c = gender);
            insert account;
        

            User user = new User();
            user.FirstName = firstName;
            user.LastName = lastName;
            user.Username = userName;
            user.CommunityNickname = communityNickname;
            user.Email = emailAddress; 
            if (profile == 'Student') {
                user.profileID = '00e5g000007azOPAAY';

            }else if (profile == 'Teacher') {
                user.profileID = '00e5g000007azOUAAY';
            }
            // String userId = Site.createExternalUser(user,account.Id,password,true);
            String userId = Site.createExternalUser(user,account.Id,password,false);
            System.debug('Id of new User => '+ userId);
            String contactId = [select ContactId from User where Id =:userId limit 1].contactId;
            if (profile == 'Student') {
                StudentC__c student = new StudentC__c(Name = account.Name , Contact__c = contactId);
                insert student;
            }else if (profile == 'Teacher') {
                Teacher__c teacher = new Teacher__c(Name = account.Name , Contact__c = contactId);
                insert teacher;
            }
            
            return 'Registered!!! with userId = '+userId;
        } catch (Exception e) {
            System.debug(e.getMessage());
            return e.getMessage();
        }
    }

    // @AuraEnabled
    // global static void sendEmail(Id userId) {
    //     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    //     List<EmailTemplate> welcomeTemplate = new List<EmailTemplate>([Select Id from EmailTemplate where name = 'newCommunityUserWelcome']);
    //     mail.setSenderDisplayName('Teacher-Student');
    //     mail.setTemplateId(welcomeTemplate[0].Id);
    //     mail.setTargetObjectId(userId);
    //     mail.setSaveAsActivity(false);
    //     Messaging.sendEmail( new List<Messaging.SingleEmailMessage>{mail} );   
    // }

    @AuraEnabled
    global static String doLogin(String username , String password) {
        System.debug('Username => '+ username);
        System.debug('Password => '+ password);

        try {
            
            // String startUrl = 'mvclouds-c8-dev-ed.develop.my.site.com/s/login/';
            String startUrl = 'mvclouds-c8-dev-ed.develop.my.site.com';
            ApexPages.PageReference pageRef = Site.login(username, password, startUrl);

            if(pageRef != null) return pageRef.getUrl();

            

            return null;


        } catch (Exception e) {
            system.debug('e.getMessagelogin+   '+e.getMessage());
            throw new AuraHandledException(e.getMessage());

            
        }
    }

    @AuraEnabled
    global static Boolean resetPassword(String username) {
        try {
            
            Boolean isSuccess = Site.forgotPassword(username,'Forgot_Password_Community');
            System.debug('response of forgot password => '+ isSuccess);
            return isSuccess;

        } catch (Exception e) {
            system.debug('e.getMessagelogin+   '+e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }


    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}        
    public PageReference changePassword() {
        return Site.changePassword(newPassword, verifyNewPassword, oldpassword);    
    }  



}   


