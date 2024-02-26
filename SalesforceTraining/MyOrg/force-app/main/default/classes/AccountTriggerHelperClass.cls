public with sharing class AccountTriggerHelperClass {
    public AccountTriggerHelperClass() {

    }
    public static void sendEmailWhenNameChange(List<Account> Accounts,Map<Id,Account> AccountsOldMap){
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        for(Account account:Accounts){
            Account oldAccount = AccountsOldMap.get(account.Id);
            if(account.Name != oldAccount.Name){

                List<Contact> contacts= [select Email,Name from Contact where AccountId =: account.Id];

                for(Contact contact:contacts){

                    if(contact.Email != null){

                        List<String> sendTo = new List<String>();
                        sendTo.add(contact.Email);
                        Messaging.SingleEmailMessage newEmail = new Messaging.SingleEmailMessage();
                        newEmail.setToAddresses(sendTo);
                        newEmail.setSubject('Contact Name Changed');
                        String body = 'Hello' + contact.Name + '<br>';
                        body += 'Your Account Name has been changed from '+ oldAccount.Name + ' to ' + account.Name + '<br>';
                        body += 'Warm Regards <br> LJ University';
                        newEmail.setHtmlBody(body);
                        mailList.add(newEmail);

                    }
                }
            }
        }
        Messaging.sendEmail(mailList);
    }

    public static void addPrefix(List<Account> Accounts){
        for(Account account:Accounts){
            if(account.Gender__c == 'Male'){
                account.Name = 'Mr.'+account.Name;
            }
            else if(account.Gender__c == 'Female'){
                account.Name = 'Mrs.'+account.Name;
            }
        }
    }

    public static void createContact(List<Account> Accounts){
        for(Account account:Accounts){
            Contact newContact = new Contact();
            newContact.LastName = account.Name;
            newContact.AccountId = account.Id;
            insert newContact;
        }
    }

    public static void deleteSameNameAccount(List<Account> Accounts){
        for(Account account:Accounts){
            List<Account> sameNameAccounts = [select Id,Name from Account where Name=:account.Name ];
            if(sameNameAccounts.size()>0){
                delete sameNameAccounts;
            }
        }
    }

    // public static void shareRecordWithWilson(List<Account> Accounts){
    //     for(Account account:Accounts){
    //         if (account.Rating == 'Hot') {
                
    //             AccountShare shareAccount = new AccountShare();
    //             shareAccount.AccountId = account.Id;
    //             shareAccount.UserOrGroupId = '0055g00000K4pfZAAR';
    //             shareAccount.AccountAccessLevel = 'Edit';
    //             shareAccount.OpportunityAccessLevel = 'Edit';
    //             shareAccount.RowCause = Schema.AccountShare.RowCause.Manual; // reason
    //             insert shareAccount;
    //             System.debug('Record Shared with Wilson');
    //         }
    //     }
    // }

    public static void submitForApproval(List<Account> Accounts){
        for (Account account : Accounts) {
            Approval.ProcessSubmitRequest request = new Approval.ProcessSubmitRequest();
            request.setComments('Submitting request for approval.');
            request.setObjectId(account.Id);
            request.setProcessDefinitionNameOrId('highPriority');
            request.setSkipEntryCriteria(true);
            Approval.ProcessResult result = Approval.process(request);
            System.debug('result='+result);
        }
    }

    // RollUp Amount
    public static void setTotalAmount(List<Account> Accounts){
        for (Account account : Accounts) {
            account.Total_Amount__c = 0;
            List<Contact> relatedContacts = [select Amount__c from Contact where AccountId =: account.Id];
            for (Contact contact : relatedContacts) {
                account.Total_Amount__c += contact.Amount__c;
            }

        }
    }

    
}