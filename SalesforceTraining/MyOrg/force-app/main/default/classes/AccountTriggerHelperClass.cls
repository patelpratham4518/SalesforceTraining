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
                        String body = 'Hello' + contact.Name + '\n';
                        body += 'Your Account Name has been changed from '+ oldAccount.Name + ' to ' + account.Name;
                        body += 'Warm Regards \n LJ University';
                        newEmail.setHtmlBody(body);
                        mailList.add(newEmail);

                    }
                }
            }
        }
        Messaging.sendEmail(mailList);
    }
}