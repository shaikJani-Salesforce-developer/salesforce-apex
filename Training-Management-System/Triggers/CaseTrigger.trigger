trigger CaseTrigger on Case (before insert,before update) {
    
    //If a Case has been in "Working" status for more than 3 days, automatically update status to "Escalated".
    if(Trigger.isbefore && Trigger.isUpdate){
       
        for(Case caseNew : Trigger.new){
            if(caseNew.Status == 'Working' && caseNew.createdDate <= System.now().addDays(-3)){
                caseNew.Status = 'Escalated';
              
            }
        }
      
    }
    /*When a Case is created:

If Origin = 'Phone', set Priority = 'High'.

If Origin = 'Web', set Priority = 'Medium'.

Otherwise, set Priority = 'Low'*/
    
    if(Trigger.isBefore && Trigger.isInsert){
        for(Case newCase : Trigger.new){
            if(newCase.Origin == 'Phone'){
                newCase.Priority = 'High';
            }
            else if(newCase.Origin == 'Web'){
                newCase.Priority = 'Medium';
            }
            else{
                newCase.Priority = 'Low';
            }
        }
    }
    /*✅ Task 3 — Auto-update Subject for Working Cases

Rule:
If a Case’s Status = 'Working' and Priority = 'High',
update the Subject to 'High Priority Case - Immediate Attention'. */
    
    if(Trigger.isBefore && Trigger.isInsert){
        for(Case newCase:Trigger.new){
            if(newCase.Priority == 'High'&& newCase.Status =='Working'){
                newCase.Subject = 'High Priority Case - Immediate Attention';
            }
        }
    }
    /*✅ Task 4 — Auto-set Case Reason based on Status

Rule:
When a Case’s Status changes to Escalated,
automatically set the Reason = 'Performance'
} */ 
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Case caseNew:Trigger.New){
            if(caseNew.Status == 'Escalated'){
                CaseNew.Reason = 'Performance';
            }
        }
    }
    /*✅ Task 5 — Auto-set Case Due Date based on Priority
Business Rule:

When a Case is created or Priority is updated:

If Priority = High, set Due_Date__c = Today + 1 day

If Priority = Medium, set Due_Date__c = Today + 3 days

If Priority = Low, set Due_Date__c = Today + 5 days */
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Case newCase : Trigger.new){
            if(newCase.Priority == 'High'){
                newCase.Due_Date__c = Date.today().addDays(1);
            }
            else if(newCase.Priority == 'Medium'){
                newCase.Due_Date__c =Date.today().addDays(3);
            }
            else if(newCase.Priority == 'Low'){
                newCase.Due_Date__c = Date.today().addDays(5);
            }
        }
    }
  }
