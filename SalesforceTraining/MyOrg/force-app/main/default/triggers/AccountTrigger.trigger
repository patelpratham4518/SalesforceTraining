trigger AccountTrigger on Account (before update) {
        if(Trigger.isBefore & Trigger.isUpdate){
            Map<Id,Account> oldMap = Trigger.oldMap;
            AccountTriggerHelperClass.sendEmailWhenNameChange(Trigger.new,oldMap);
        }
}