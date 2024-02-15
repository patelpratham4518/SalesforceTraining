public with sharing class ContactTriggerHelperClass {
    public ContactTriggerHelperClass() {

    }

    public static void deleteRelatedAccount(List<Contact> contacts){
            
        for(Contact contact:contacts){
            Id relatedAccountId = contact.AccountId;
            if(relatedAccountId != null){
                Account relatedAccount = new Account();
                relatedAccount.Id = relatedAccountId;
                delete relatedAccount;
            }
        }
    }

    public static void createRelatedEvent(List<Contact> contacts){
        // System.debug(contacts);
        for(Contact contact:contacts){
            Event event = new Event();
            event.IsAllDayEvent = true;
            event.ActivityDate = Date.today();
            event.OwnerId = contact.OwnerId;
            event.WhoId = contact.Id; 
            event.Type = 'Meeting';
            event.Subject = 'Meeting';
            insert event;

        }
    }

    public static void setTotalAmountInsert(List<Contact> contacts){
        for (Contact contact : contacts) {
            if (contact.AccountId != null) {
                Account relatedAccount = [select Id,Name,Total_Amount__c from Account where Id =: contact.AccountId];
                relatedAccount.Total_Amount__c += contact.Amount__c;
                update relatedAccount;
            }
        }
    }

    public static void setTotalAmountUpdate(List<Contact> contacts , Map<Id,Contact> oldMap){
        for (Contact contact : contacts) {
            if (contact.AccountId != null) {
                Account relatedAccount = [select Id,Name,Total_Amount__c from Account where Id =: contact.AccountId];
                relatedAccount.Total_Amount__c -= oldMap.get(contact.Id).Amount__c;
                relatedAccount.Total_Amount__c += contact.Amount__c;
                update relatedAccount;
            }
        }
    }

    //Sheep Problem
    public static void changeSibblingAccount(List<Contact> contacts , Map<Id,Contact> oldMap){
        for (Contact contact : contacts) {

            if (contact.AccountId != oldMap.get(contact.Id).AccountId) {
                List<Contact> contactsToChange = [select AccountId from Contact where AccountId =: oldMap.get(contact.Id).AccountId ];
                for (Contact contactToChange : contactsToChange) {
                    contactToChange.AccountId = contact.AccountId;
                }
                update contactsToChange;
            }

        }
    }

    //The Great Problem
    public static void checkMaxAmount(List<Contact> contacts){
        for (Contact contact : contacts) {
            if (contact.AccountId != null) {
                Account relatedAccount  = [select Id,Max_Amount_For_Contact__c from Account where Id =: contact.AccountId];

               
                if (relatedAccount.Max_Amount_For_Contact__c == 0) {
                    contact.Amount__c.addError('Your parent account has zero amount Limit');
                }
                else {
                    if (contact.Amount__c > relatedAccount.Max_Amount_For_Contact__c) {
                        System.debug('Divide Contacts');
                        Decimal remainingAmount = contact.Amount__c;
                        contact.Amount__c = relatedAccount.Max_Amount_For_Contact__c;
                        remainingAmount -= relatedAccount.Max_Amount_For_Contact__c;
                        Contact newContact = contact.clone(false);
                        newContact.Amount__c =  remainingAmount;

                        String lastName = contact.LastName;

                        String copyCount = lastName.right(1);
                        try {
                            Integer copyCountNew = Integer.valueOf(copyCount);
                            copyCountNew += 1;
                            lastName = lastName.removeEnd(copyCount);
                            lastName += copyCountNew;
                        } catch (Exception e) {
                            lastName += 2;
                        } 
                        newContact.LastName = lastName;
                        insert newContact;
                    }
                }

                
            }
        }
    }

}