global  class updateAccountNameWithOpportunity implements Database.Batchable<sObject> {
    public updateAccountNameWithOpportunity() {

    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select Name,Account.Name from Opportunity where AccountId != null]);
    }
    global void execute (Database.BatchableContext bc, List<Opportunity> Opportunities){

        for (Opportunity opportunity : Opportunities) {
            opportunity.Name = opportunity.Account.Name;
        }
        update Opportunities;
    }
    global void finish(Database.BatchableContext bc){
        System.debug('Finished updating account name with opportunity.');
    }
}