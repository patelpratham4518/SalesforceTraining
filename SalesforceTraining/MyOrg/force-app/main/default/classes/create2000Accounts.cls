public with sharing class create2000Accounts implements Queueable{
    public void execute(QueueableContext context) {
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<2000;i++){
            Account account = new Account(Name = 'WORKBENCH ACC'+i.toString() , Gender__c = 'Others');
            accList.add(account);
        }
        insert accList;
        //to delete above records
        // List<Account> Accounts = [select Id,Name from Account where Name like 'WORKBENCH%'];
        // delete Accounts;
    }
}
//7075g00009CGGWI