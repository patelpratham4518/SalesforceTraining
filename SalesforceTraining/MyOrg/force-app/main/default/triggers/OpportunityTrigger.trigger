trigger OpportunityTrigger on Opportunity (before insert , before update , after update) {
        if(Trigger.isBefore & Trigger.isUpdate){
            OpportunityTriggerHelperClass.stageNameAndCloseDate(Trigger.new);
        }
        if(Trigger.isBefore & Trigger.isInsert){
            OpportunityTriggerHelperClass.typeNewCustomer(Trigger.new);
        }
        if(Trigger.isAfter & Trigger.isUpdate){
            Map<Id,Opportunity> oldMap = Trigger.oldMap;
            OpportunityTriggerHelperClass.createTaskForOwner(Trigger.new,oldMap);
        }
}