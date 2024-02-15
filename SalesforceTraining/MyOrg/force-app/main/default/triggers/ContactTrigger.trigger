trigger ContactTrigger on Contact (after delete , after insert ,before insert, after update , before update) {
    if(Trigger.isAfter & Trigger.isDelete){
        ContactTriggerHelperClass.deleteRelatedAccount(Trigger.old);
    }
    if(Trigger.isAfter & Trigger.isInsert){
        ContactTriggerHelperClass.createRelatedEvent(Trigger.new);
        // rollUp Amount
        ContactTriggerHelperClass.setTotalAmountInsert(Trigger.new);
    }
    if (Trigger.isAfter & Trigger.isUpdate ) {
        // rollUp Amount
        ContactTriggerHelperClass.setTotalAmountUpdate(Trigger.new , Trigger.oldMap );
        
        //Sheep Problem
        ContactTriggerHelperClass.changeSibblingAccount(Trigger.new,Trigger.oldMap);
    }

    if (Trigger.isBefore & (Trigger.isInsert | Trigger.isUpdate)) {
        //The Great Problem
        ContactTriggerHelperClass.checkMaxAmount(Trigger.new);
    }

    
}