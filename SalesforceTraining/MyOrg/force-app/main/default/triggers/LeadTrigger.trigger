trigger LeadTrigger on Lead (before insert) {
        if(Trigger.isBefore & Trigger.isInsert){
            LeadTriggerHelperClass.ratingHotOnInsert(Trigger.new);
        }
}