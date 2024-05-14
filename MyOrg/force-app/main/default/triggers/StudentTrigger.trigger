trigger StudentTrigger on Student__c (before insert,after insert,before delete , after delete,before update,after update, after undelete) {
        System.debug('Trigger.new'+Trigger.new);
        System.debug('Trigger.old'+Trigger.old);
        System.debug('Before'+ Trigger.isBefore);
        System.debug('After'+ Trigger.isAfter);
        System.debug('Insert'+ Trigger.isInsert);
        System.debug('Update'+ Trigger.isUpdate);
        System.debug('Delete'+ Trigger.isDelete);
        System.debug('Undelete' + Trigger.isUndelete);
        System.debug('Size'+ Trigger.size);

        Map<Id,Student__c> newMap = new Map<Id,Student__c>();
        newMap = Trigger.newMap;
        Map<Id,Student__c> oldMap = new Map<Id,Student__c>();
        oldMap = Trigger.oldMap;
        System.debug('newMap='+newMap);
        System.debug('oldMap='+oldMap);

}