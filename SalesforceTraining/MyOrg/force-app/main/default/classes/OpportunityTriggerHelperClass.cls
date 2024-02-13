public with sharing class OpportunityTriggerHelperClass {
    public OpportunityTriggerHelperClass() {

    }
    public static void stageNameAndCloseDate(List<Opportunity> opportunities){
        for(Opportunity opportunity:opportunities){
            opportunity.StageName = 'Prospecting';
            Date newDate = Date.today().addDays(15);
            opportunity.CloseDate = newDate; 
        }
    }

}