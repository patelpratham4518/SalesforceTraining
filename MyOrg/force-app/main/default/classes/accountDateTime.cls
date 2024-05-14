global class accountDateTime implements Database.Batchable<sObject> , Schedulable{
    public accountDateTime() {
    }

    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select Description from Account]);
    }

    global void execute (Database.BatchableContext bc, List<Account> Accounts){
        for (Account account : Accounts) {
            account.Description = DateTime.now().toString();
        }
        update Accounts;
    }
    global void finish (Database.BatchableContext bc){
        System.debug('DateTime Updated');
    }

    global void execute(SchedulableContext sc){
        accountDateTime exec = new accountDateTime();
        Database.executeBatch(exec);
    }
    
}