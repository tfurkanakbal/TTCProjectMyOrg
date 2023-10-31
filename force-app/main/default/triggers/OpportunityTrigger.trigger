trigger OpportunityTrigger on Opportunity (after update) {

    If(Trigger.isAfter && Trigger.isUpdate){
        OpportunityTriggerHandler.OppClosedWonTask(Trigger.new,trigger.OldMap);
    }
    
}