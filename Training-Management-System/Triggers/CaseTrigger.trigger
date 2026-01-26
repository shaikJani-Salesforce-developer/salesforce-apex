trigger CaseTrigger on Case (before insert,before update,before delete,After insert,after update,after delete,after undelete) {

/*Whenever a Case is created, updated or closed
✅ Look at ALL related Cases under the Account
✅ If any Case is Closed with High Priority in last 30 days
→ Customer_Health__c = "Healthy"

✅ Else if any Open Case exists
→ Customer_Health__c = "At Risk"

✅ Else
→ Customer_Health__c = "Inactive"*/
    if(trigger.isAfter && Trigger.isInsert || Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Case c :Trigger.new){
            if(c.accountid !=null){
                accountIds.add(c.accountid);
            }
        }
        set<id> closedAndHighCases = new set<id>();
        for(Case c :[select id,accountid,Priority,Status,ClosedDate from case 
                     where accountid IN:accountIds and ClosedDate = Last_N_Days:30 ]){
                         
             if(c.Priority == 'High' && c.Status__c == 'Closed'){
                closedAndHighCases.add(c.AccountId);
            }   
        }
        set<id> openCases = new set<id>();
        for(Case c :[select id,accountid,Priority,Status,ClosedDate from case 
                     where accountid IN:accountIds and ClosedDate = Last_N_Days:30]){
                         
            if(c.Status != 'Closed' && c.Priority == 'High' ){
                openCases.add(c.AccountId);
            }
        }
        Map<id,Account> accsMap = new Map<id,account>([select id,name,Customer_Health__c from Account
                                                        where id IN: accountIds]);
        for(Account account :accsMap.values()){
            if(closedAndHighCases.contains(account.id)){
                account.Customer_Health__c = 'Healthy';
            }
            else if(openCases.contains(account.id)){
                account.Customer_Health__c = 'At Risk';
            }
            else{
                account.Customer_health__c = 'Inactive';
            }
        }
        update accsMap.values();
    }
    /*A Case cannot be created for an Account unless:

1️⃣ The Account has at least ONE Active Contact
2️⃣ Active Contact means:

Contact.Status__c = 'Active'

Contact.Email != null*/
    if(Trigger.isBefore && Trigger.isInsert){
        set<id> accountIds = new set<id>();
        for(Case c :Trigger.new){
            if(c.accountid !=null){
                accountIds.add(c.AccountId);
                
            }
        }
          Map<id,Integer> activeContacts = new Map<id,Integer>();
        for(AggregateResult ar :[select accountid,count(id) cnt from Contact where accountid IN: accountIds
                                       And Status__c ='Active' And Email != Null Group By Accountid]){ 
                     
               activeContacts.put((id) ar.get('accountid'), (Integer) ar.get('cnt'));    
                                           
      }
        for(Case c :Trigger.new){
            if(c.accountid != null && !activeContacts.containsKey(c.AccountId)){
                c.addError('Cannot create Case. Account must have at least one Active Contact with Email');
            }
        }
    }
    /*When a Case is escalated (IsEscalated = true):

1️⃣ The Account Escalation_Level__c must be updated automatically
2️⃣ Logic:

If Account.Type = Customer → Escalation_Level__c = High

Else → Escalation_Level__c = Medium*/
    
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Case c :Trigger.new){
            
         Case  oldCase  = Trigger.oldMap.get(c.id);
            if(oldCase.IsEscalated == false && c.IsEscalated ==true && c.AccountId !=null ){
                accountIds.add(c.AccountId);
            }
        }
        list<Account> accsToUpdate = new list<Account>();
        for(Account account :[select id,type,Escalation_Level__c from Account where id IN:accountIds]){
            if(account.type == 'Customer'){
                account.Escalation_Level__c = 'High';
            }
            else{
                account.Escalation_Level__c = 'Medium';
            }
            accsToUpdate.add(account);
        }
        update accsToUpdate;
    }
    /*Whenever a Case is created or updated:

✅ Look at ALL related Opportunities under the same Account
✅ If any Open Opportunity > ₹5,00,000
AND any High Priority Case is Open
→ Set Account.Revenue_At_Risk__c = true

✅ Else
→ Set Account.Revenue_At_Risk__c = false*/
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        for(Case c :Trigger.new){
            if(c.AccountId != null){
                accountIds.add(c.AccountId);
            }
        }
        set<id> riskyOppAccs = new set<id>();
      for(Opportunity opp :[select accountid,Amount,Stagename from Opportunity
                                 where accountid IN:accountids And 
                                 StageName NOT IN('Closed Won', 'Closed Lost') 
                                 And Amount >500000]){
                                            
               riskyOppAccs.add(opp.accountid);
            }
        
          set<id> highPriorityCases = new set<id>();
        for(case c :[select accountid,status__c,priority from case 
                       where accountid IN: accountIds]){
                           
            if(c.Priority == 'High' && c.Status__c != 'Closed'){
                highPriorityCases.add(c.AccountId);
            }
        }
        
          list<Account> accountsToUpdate = new list<Account>();
        for(Account account :[select id,name,Revenue_At_Risk__c from Account
                                  where id IN:accountIds]){
                                      
            if(riskyOppAccs.contains(account.id) && 
                   highPriorityCases.contains(account.id)){
                       
                account.Revenue_At_Risk__c = true;
            }
            else{
                account.Revenue_At_Risk__c = false;
            }
            accountsToUpdate.add(account);
        }
        update accountsToUpdate;
    }
}
//Prevent Case deletion if it is associated with a Contact
    if(Trigger.isBefore && Trigger.isDelete){
        for(Case caseOld :Trigger.old){
            if(caseOld.contactid != null){
 caseOld.addError('cannot delete case because it is associated with a Contact');
            }
        }
    }
    /*If any Case under an Account is High Priority,
set Account.Has_High_Priority_Case__c = true
If no high priority cases exist → false*/
    if(Trigger.isAfter && Trigger.isInsert){
        set<id> accountids = new set<id>();
        for(Case c : Trigger.new){
            if(c.accountid !=null){
                accountIds.add(c.accountid);
            }
        }
        //load priority high cases in set
        set<id> highPriorityCases = new set<id>();
        for(Case c :Trigger.new){
            if(c.accountid !=null && c.Priority=='High'){
                highPriorityCases.add(c.accountId);
            }
        }
Map<id,Account> accsMap = new Map<id,Account>([select id,name,Has_High_Priority_Case__c
                                               from Account where id IN:accountIds]);
        for(Account account : accsMap.values()){
            if(highPriorityCases.contains(account.id)){
                account.Has_High_Priority_Case__c = true;
            }
            else{
                account.Has_High_Priority_Case__c = false;
            }
        }
        update accsMap.values();
    }  

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
