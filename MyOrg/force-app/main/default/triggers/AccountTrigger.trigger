trigger AccountTrigger on Account (before update, after update, before insert , after insert) {
        if(Trigger.isBefore & Trigger.isUpdate){
            Map<Id,Account> oldMap = Trigger.oldMap;
            AccountTriggerHelperClass.sendEmailWhenNameChange(Trigger.new,oldMap);
            //RollUp Amount
            AccountTriggerHelperClass.setTotalAmount(Trigger.new);
        }
        
        if(Trigger.isBefore & Trigger.isInsert){
            AccountTriggerHelperClass.addPrefix(Trigger.new);
            AccountTriggerHelperClass.deleteSameNameAccount(Trigger.new);
        }

        if(Trigger.isAfter & Trigger.isInsert){
            AccountTriggerHelperClass.createContact(Trigger.new);
            AccountTriggerHelperClass.submitForApproval(Trigger.new);

        }

        if (Trigger.isAfter & Trigger.isUpdate) {
            // Before using below trigger Set Account,Case and Opportunity OWD Private and uncomment this method from helper class
            //AccountTriggerHelperClass.shareRecordWithWilson(Trigger.new);
        }


}