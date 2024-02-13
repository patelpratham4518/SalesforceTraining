trigger OpportunityTrigger on Opportunity (before insert , before update) {
        if(Trigger.isBefore & Trigger.isUpdate){
            OpportunityTriggerHelperClass.stageNameAndCloseDate(Trigger.new);
        }
}