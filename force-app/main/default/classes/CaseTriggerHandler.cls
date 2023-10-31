public class CaseTriggerHandler {
    
    public static void updateCaseWithParentId(List<Case> newCases){
        
        Set<Id> setAccount = new Set<Id>(); //Creates a set of Account Ids that are associated with the new Case Record    
        Map<Id, List<Case>> accountToCase = new Map<Id , List<Case>>(); //store the related Case records for each Account in a map where the Account Id is the key
        
        for(Case c : newCases){
            if(String.isNotBlank(c.AccountId)){
                setAccount.add(c.AccountId);
            }
        }
            List<Account> lstAccount = [SELECT Id ,
                                       (SELECT Origin , ParentID, AccountId FROM Cases ORDER BY CreatedDate DESC)
                                       FROM Account WHERE Id In: setAccount];
            //Query The Account records with those Ids and retrieves all the related Case records using a nested subquery.
            
            for(Account a : lstAccount){
                accountToCase.put(a.Id,a.Cases);
            }
            for(Case c : newCases){
            if(String.isNotBlank(c.AccountId)){
                    for(case oldCase : accountToCase.get(c.AccountId)){
                        if((c.Origin==oldCase.Origin)){
                            c.ParentId=oldCase.Id;
                            break;
       //Finally, for each new Case record , the trigger handler looks up the related Account's Cases and finds the most recent Case record with the same Origin value.
       //It hen sets the new Case records ParentId to the of the matching Case record                     
                    }                  
                }
            }
        }            
    }
}