public with sharing class createContactAura {
    
    public createContactAura() {
        
    }
    @AuraEnabled
    public static string createContactApex(String FirstName ,String LastName , Integer Mobile,String Email){
        try {
            Contact contact = new Contact(FirstName = FirstName , LastName = LastName , Phone = Mobile.toString(), Email = Email);
            insert contact;
            System.debug('Inside apex class');
            return 'Contact Inserted';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Account> getAccounts(String searchString){
        try {
            String query = 'select Id,Name from Account where Name like '+ searchString + '% limit 5';
            List<Account> accList = Database.query(query);
            return accList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}