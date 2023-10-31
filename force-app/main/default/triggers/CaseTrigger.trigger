trigger CaseTrigger on Case (before insert) {
    
    If(Trigger.isBefore && Trigger.isInsert){
        CaseTriggerHandler.updateCaseWithParentId(Trigger.New);
    }

}