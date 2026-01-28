trigger OpportunityTrigger on Opportunity(after insert,After delete,after update,after undelete,before insert,before update,before delete){
/*Whenever a new Opportunity is inserted,updated,deleted,undelted.
the parent Account should automatically update the Total_Opportunities__c field to 
show the total number of Opportunities linked to that Account.*/
    if(Trigger.isAfter && 
    (Trigger.isInsert|| Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)){
              set<id> accountIds = new set<id>();
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
            for(Opportunity opportunity :Trigger.new){
                if(opportunity.accountid != null){
                    accountids.add(opportunity.AccountId);
                }
            }
        } 
            if(Trigger.isDelete || Trigger.isUpdate){
                for(Opportunity opportunity :Trigger.old){
                    if(opportunity.AccountId !=null){
                        accountIds.add(opportunity.AccountId);
                    }
                }
            }
             Map<id,integer> totalOppsCount = new Map<id,Integer>();
            for(AggregateResult ar :[select accountid,count(id) totalOpps from Opportunity
                                     where accountid IN:accountIds Group by accountId]){
                     
                totalOppscount.put((id) ar.get('accountid'), (integer) ar.get('totalOpps'));
                                         
            }
            list<Account> accountsToUpdate = new list<Account>();
            for(Account account :[select id,name,Total_Opportunities__c from Account 
                                   where id IN:accountIds]){
                                       
                if(totalOppsCount.containsKey(account.id)){
                  account.Total_Opportunities__c  = totalOppscount.get(account.id);
                }
                else{
                    account.Total_Opportunities__c =0;
                }
                accountsToupdate.add(account);
            }
            update accountsToUpdate;
        }
    

    /*Whenever Opportunities are inserted, check if any Opportunity Amount > 50,000
If yes → Account.Has_Big_Opportunity__c = true

Otherwise → false*/
    if(Trigger.isAfter && Trigger.isInsert){
        //step 1 Collect Parent account ids and load into set collection
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.accountid !=null){
                accountIds.add(opportunity.accountid);
            }
        }
        //step2 fetch parent accounts into map
map<id,Account> accsMap = new map<id,Account>([select id,Has_Big_Opportunity__c from Account 
                                               Where id IN:accountIds]);
        //step 3 set false as default value
        for(Account account : accsMap.values()){
            account.Has_Big_Opportunity__c =false;
        }
        for(Opportunity opportunity :trigger.new){
            if(opportunity.Amount >50000 && accsMap.containsKey(opportunity.accountid)){
               accsMap.get(opportunity.AccountId).Has_Big_Opportunity__c = true;
            }
        }
        if(!accsMap.isEmpty()){
            update accsMap.values();
        }
    }
    /*Whenever an Opportunity is INSERTED or DELETED,
update Account.Total_Opportunities__c
to show how many Opportunities the Account has.*/
    //for Insert Trigger.new
    set<id> accountIds = new set<id>();
    if(Trigger.isInsert){
        //collect Parent Account ids load into set collection
        for(Opportunity opportunity : Trigger.new){
            if(opportunity.AccountId !=null){
                accountIds.add(opportunity.accountid);
            }
        }
    } 
        //for delete Trigger.old
        if(Trigger.isdelete){
            //collect Parent account ids load into set 
              for(Opportunity opportunity : Trigger.old){
                if(opportunity.AccountId !=null){
                    accountIds.add(opportunity.accountid);
                }
            }
        } 
        //ftech accounts with related opportunities into List collection
           list<Account> accsToUpdate = new list<Account>([select id,name,Total_Opportunities__c,
                                        (select id,name from Opportunities)from Account where id IN:accountIds]);
            for(Account account : accsToUpdate){
                account.Total_Opportunities__c = account.opportunities.size();
            }
            if(!accsToUpdate.isEmpty()){
                update accsToUpdate;
            }
    /*Whenever an Opportunity is INSERTED or UPDATED,
update the parent Account field Latest_Opportunity_CloseDate__c
with the Opportunity CloseDate.*/
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        //collect parents account ids into set
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.AccountId !=null){
                accountIds.add(opportunity.AccountId);
            }
        }
        //fetch account related opportunities into map
        map<id,Account> accsMap = new map<id,Account>([select id,name,Latest_Opportunity_CloseDate__c from Account
                                                      where id IN:accountIds]);
        
        for(Opportunity opportunity :Trigger.new){
            if(accsMap.containsKey(opportunity.AccountId)){
                accsMap.get(opportunity.AccountId).Latest_Opportunity_CloseDate__c = opportunity.CloseDate;
            }
        }
        
        update accsMap.values();
    } 
    //Prevent Opportunity deletion if it has OpportunityLineItems
    //opportunitylineitem is child object
    if(Trigger.isBefore && Trigger.isDelete){
        set<id> opportunityIds = new set<id>();
        for(Opportunity opportunity : Trigger.old){
            opportunityIds.add(opportunity.id);
        }
        // fetch opportunityLineItems
        set<id> oppsWithOpps = new set<id>();
        for(OpportunityLineItem opportunityLineItem :[select opportunityid from OpportunityLineItem 
                                                       where opportunityid IN:opportunityIds]){
                 oppsWithOpps.add(opportunityLineItem.opportunityid);                     
          }
        
        for(Opportunity opportunity :Trigger.old){
            if(oppsWithOpps.contains(opportunity.id)){
                opportunity.addError('Cannot delete Opportunity because it has Products (Line Items');
            }
        }
          
        
    }

  /*On Opportunity, when StageName = Closed Won → 
update the parent Account field Total_Closed_Won_Opportunities__c 
with the total number of Closed Won Opportunities for that account*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> closedWonOpps = new set<id>();
        for(Opportunity opportunity :Trigger.new){
             Opportunity oldOpportunity = trigger.oldMap.get(opportunity.id);
            if(oldOpportunity.StageName != 'Closed Won' && opportunity.StageName == 'Closed Won' && opportunity.accountid != null){
                closedWonOpps.add(opportunity.AccountId);
            }
        }
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity : Trigger.new){
            if(opportunity.AccountId !=null){
                accountIds.add(opportunity.AccountId);
            }
        }
        //fetch accounts 
       list<Account> accsList = new list<Account>([select id,name,Total_Closed_Won_Opportunities__c,
                                             (select id,StageName from Opportunities) from Account where id IN:accountIds]);
        
        for(Account account : accsList){
            if(closedWonOpps.contains(account.id)){
                account.Total_Closed_Won_Opportunities__c = account.opportunities.size();
            }
        }
        update accsList;
    } 
    /*Business Rule (Random Example):

On Opportunity, if Amount > 1,00,000 and StageName = Prospect, update the parent Account field High_Value_Opportunity__c = true.
Otherwise, if no child Opportunity satisfies this, set High_Value_Opportunity__c = false.*/
    
    if(Trigger.isAfter && Trigger.isUpdate){
        
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity : Trigger.new){
            if(opportunity.AccountId !=null){
                accountIds.add(opportunity.AccountId);
            }
        }
        set<id> stageAndAmountOpps = new set<id>();
        for(Opportunity opportunity :trigger.new){
            if(opportunity.StageName == 'Prospect' && opportunity.Amount >100000 && opportunity.AccountId !=null){
                stageAndAmountOpps.add(opportunity.AccountId);
            }
        }
        Map<id,Account> accsMap = new Map<id,Account>([select id,name,High_Value_Opportunity__c from Account
                                                      where id IN:accountIds]);
        
        for(Account account :accsMap.values()){
            if(stageAndAmountOpps.contains(account.id)){
                account.High_Value_Opportunity__c = true;
            }
            else{
                account.High_Value_Opportunity__c = false;
            }
        }
        update accsMap.values();
    }
   /*Whenever an Opportunity is inserted or updated,
if the Opportunity Stage = 'Closed Won'
and Amount ≥ 1,00,000,
then update the parent Account field High_Revenue_Customer__c = true.
If an Account has no Closed Won Opportunities with Amount ≥ 1,00,000,
then set High_Revenue_Customer__c = false.*/
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.accountid !=null){
                accountIds.add(opportunity.accountid);
            }
        }
        set<id> stageAndAmountOpps = new set<id>();
        for(Opportunity opportunity :Trigger.new){
if(opportunity.StageName =='Closed Won' && opportunity.Amount >= 100000 && 
                             opportunity.AccountId !=null){
                stageAndAmountOpps.add(opportunity.accountid);
            }
        }
map<id,Account> accsMap = new Map<id,Account>([select id,name,High_Revenue_Customer__c
                                               from Account where id IN:accountIds]);
        
        for(Account account : accsMap.values()){
            if(stageAndAmountOpps.contains(account.id)){
                account.High_Revenue_Customer__c = True;
            }
            else{
                account.High_Revenue_Customer__c = false;
            }
        }
        update accsMap.values();
    }
    /*Plain English (Very Simple)

Opportunity is created or updated

Check LastModifiedDate

If any Opportunity under the Account is recent (≤ 30 days)

→ Account.Active__c = Yes

Else → No*/
    if(trigger.isAfter && (trigger.isInsert ||Trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.AccountId != null){
                accountIds.add(opportunity.AccountId);
            }
        }
          set<id> oppsIds = new set<id>();
        for(Opportunity opportunity :[select id,Name,accountId,LastModifiedDate from Opportunity
                                      where accountId IN:accountIds]){
         if(opportunity.LastModifiedDate.Date() >= system.today().addDays(-30) && (opportunity.AccountId !=null)){
                       oppsIds.add(opportunity.AccountId);                      
  }             
     }
        //fetch accounts
        Map<id,Account> accsMap = new Map<id,Account>([select id,Name,Active__c from Account
                                                      where id IN:accountIds]);
        
        for(Account account :accsMap.values()){
            if(oppsIds.contains(account.id)){
                account.Active__c = 'Yes';
            }
            else{
                account.Active__c = 'No';
            }
        }
        update accsMap.values();
    }
    /*Requirement
When an Opportunity is inserted or updated
→ If any Opportunity under an Account has Stage = 'Closed Won'
→ Set Account.Has_Closed_Won__c = true
Else → false*/
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.AccountId !=null){
                accountIds.add(opportunity.AccountId);
            }
        } 
        set<id> closedWonOpps= new set<id>();
        for(Opportunity opportunity :[select id,name,stagename,accountid from Opportunity where accountid IN:accountids]){
            if(opportunity.StageName == 'Closed Won'){
                closedWonOpps.add(opportunity.AccountId);
            }
        }
        //fetch accounts
        Map<id,Account> accsMap = new Map<id,Account>([select id,name,Has_Closed_Won__c from Account
                                                      where id IN:accountIds]);
        for(Account account :accsMap.values()){
            if(closedWonOpps.contains(account.id)){
                account.Has_Closed_Won__c = true;
            }
            else{
                account.Has_Closed_Won__c = false;
            }
        }
        update accsMap.values();
        
    }
    /*Do NOT allow Opportunity to be inserted or updated
IF its Account.Status__c = 'Inactive'*/
            
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
            set<id> accountIds = new set<id>();
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.AccountId != null){
                accountIds.add(opportunity.AccountId);
            }
        }
        Map<id,Account> accsMap = new Map<id,Account>([select id,name,Status__c from Account
                                                      where id IN:accountIds]);
        
     
        for(Opportunity opportunity :Trigger.new){
            if(accsMap.containsKey(opportunity.AccountId)){
              if(accsMap.get(opportunity.AccountId).Status__c == 'Inactive'){
                    opportunity.addError('You Cannot Insert Opportunity Record');
                }
                
            }
        }
    }

    /*When an Opportunity is created, updated, deleted, or restored, its Account must be recalculated.
The Account should store the sum of Amount of all related Opportunities except “Closed Lost” ones.
If no valid Opportunities exist, the Account total should be 0.*/
    
               if (Trigger.isAfter && 
   (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete)) {

    Set<Id> accountIds = new Set<Id>();

    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
        for (Opportunity opp : Trigger.new) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
       }
 if (Trigger.isDelete) {
        for (Opportunity opp : Trigger.old) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
    }

    Map<Id, Decimal> accToTotalMap = new Map<Id, Decimal>();

    for (AggregateResult ar : [SELECT AccountId accid, SUM(Amount) total FROM Opportunity
                                WHERE AccountId IN :accountIds AND StageName != 'Closed Lost' GROUP BY AccountId]) {
                                    
        accToTotalMap.put((Id) ar.get('accid'),(Decimal) ar.get('total'));
    }

    List<Account> accountsToUpdate = [ SELECT Id, Total_Opportunity_Amount__c FROM Account WHERE Id IN :accountIds];

    for (Account acc : accountsToUpdate) {
        if (accToTotalMap.containsKey(acc.Id)) {
            acc.Total_Opportunity_Amount__c = accToTotalMap.get(acc.Id);
        } else {
            acc.Total_Opportunity_Amount__c = 0;
        }
    }

    update accountsToUpdate;
}
    /*When an Opportunity is updated
 If the Stage changes to 'Closed Won', automatically create a related Task for the Account Owner
 The Task should have Subject = "Follow up on Closed Won Opportunity" and Due Date = Today + 3 days*/
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Task> insertTasks = new List<Task>();
        for(Opportunity opportunity :Trigger.new){
         Opportunity oldOpp  = Trigger.oldMap.get(opportunity.id);
            if(oldOpp.StageName != 'Closed Won' && opportunity.StageName == 'Closed Won' && opportunity.accountId !=null){
                Task task = new Task();
                task.Subject = 'Follow Up on Closed Won Opportunity';
                task.ActivityDate = date.today().addDays(3);
                task.whatId = opportunity.AccountId;
                task.OwnerId = opportunity.OwnerId;
                insertTasks.add(task); 
            }
        } 
         
       insert insertTasks;
    }
    /*When Opportunities are inserted, updated, deleted, or undeleted
Recalculate Account.Customer_Health__c based on multiple conditions:
If any Closed Won Opportunity in last 90 days → Healthy
Else if any Open Opportunity → At Risk
Else → Inactive
This field must always stay accurate even during bulk operations*/
   } 
    /*An Account can have only ONE Opportunity
with StageName = 'Negotiation/Review' at any time.*/
    if(Trigger.isBefore && Trigger.isInsert){
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity :trigger.new){
            if(opportunity.accountid !=null){
                accountIds.add(opportunity.accountid);
            }
        }
         Map<id,Integer> oppsCount = new Map<id,Integer>();
        for(aggregateResult ar :[select accountid,count(id) cnt from Opportunity where accountid In: accountIds 
                                 And StageName = 'Negotiation/Review' Group by accountid]){
                     oppsCount.put((id) ar.get('accountid'), (Integer) ar.get('cnt'));
                                     
        }
        for(Opportunity opportunity :trigger.new){
            if(oppsCount.containsKey(opportunity.AccountId) && oppsCount.get(opportunity.AccountId) >=1 &&
               opportunity.StageName =='Negotiation/Review'){
                   
                opportunity.addError('Only one Opportunity in Negotiation/Review is allowed per Account');
            }
        }
    }
    /*Business Requirement:

If an Account is marked as Frozen (Is_Frozen__c = true):

❌ Users cannot create OR update Opportunities*/
    if(Trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.AccountId !=null){
                accountIds.add(opportunity.AccountId);
            }
        }
        Map<id,Account> accsMap = new Map<id,Account>([select id,name,Is_frozen__c from Account
                                                        where id IN:accountIds]);
        
        
        for(Opportunity opportunity :trigger.new){
            if(accsMap.containskey(opportunity.AccountId) && accsMap.get(opportunity.AccountId).is_frozen__c == true){
                opportunity.addError('This Account is frozen. You cannot create or update Opportunities.');
            }
        }
    }  
        /*Business Requirement:

Account has a field Active_Revenue__c

This field must always store:

SUM of Amount of Opportunities where

StageName = 'Closed Won'

CloseDate is in the current financial year*/
        
     if(Trigger.isAfter && (Trigger.isInsert ||Trigger.isUpdate)){
            set<id> accountIds = new set<id>();
            for(Opportunity opportunity : trigger.new){
                if(opportunity.AccountId !=null){
                    accountIds.add(opportunity.AccountId);
                }
            }
            Map<id,Decimal> closedWonTotalAmountOpps = new Map<id,Decimal>();
            for(AggregateResult ar :[select accountid,Sum(amount) total from Opportunity where accountid IN:accountIds
                                          And stagename = 'Closed Won' And CloseDate = THIS_YEAR Group by Accountid]){
                                              
          closedWonTotalAmountOpps.put((id) ar.get('accountid'), (Decimal) ar.get('total'));
                                              
        }
         List<Account> accsList = new List<Account>([select id,name,Active_Revenue__c from Account
                                                       where id IN:accountIds]);
         
         for(Account account :accsList){
             if(closedWonTotalAmountOpps.containsKey(account.id)){
                       account.active_revenue__c = closedWonTotalAmountOpps.get(Account.Id);
             }
             else{
                 account.active_revenue__c = 0;
             }
         }
         update accsList;
    }   
    /*An Opportunity CANNOT be created for an Account if the Account has any OPEN High-Priority Cases.

Conditions:

Case.Status ≠ Closed

Case.Priority = High*/
    if(Trigger.isbefore && Trigger.isInsert){
        set<id> accountIds = new set<id>();
        for(Opportunity opportunity :Trigger.new){
            if(opportunity.accountid !=null){
                accountIds.add(opportunity.AccountId);
                
            }
        }
         Map<id,Integer> highCases = new Map<id,Integer>();
        for(AggregateResult ar :[select accountId,count(id) cnt from Case where accountId IN: accountIds
                                 And Status != 'Closed' And Priority = 'High' Group By accountid]){
                                     
                  highCases.put((id) ar.get('accountid'), (integer) ar.get('cnt'));      
                                     
      }
        for(Opportunity opportunity :Trigger.new){
            if( opportunity.AccountId != null && highCases.containsKey(opportunity.AccountId)){
                opportunity.addError('Cannot create Opportunity while High Priority open Cases exist for this Account.');
            }
        }
    }
    //Opportunity stage should be prospecting and the close date should be 15 days from the day that is given

    
    if(Trigger.isBefore && Trigger.isInsert){
       // list<Opportunity> newOpps = Trigger.New;
        for(Opportunity newOpportunity : Trigger.new){
            newOpportunity.StageName = 'Prospecting';
            newOpportunity.Closedate = Date.today().adddays(15); 
            
        } 
        
    }
    /*When a new Opportunity is created or updated,
the Close Date should not be more than 90 days from today’s date.

If the Close Date is greater than 90 days from today,
throw an error saying:
“Close Date cannot be more than 90 days from today.”*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Opportunity newOpp : Trigger.New){
            if(newOpp.Closedate > Date.today().adddays(90)){
                newOpp.addError('Close Date cannot be more than 90 days from today');
            }
        }
        
        
    }
    /*When a new Opportunity record is created or updated,
if the Amount is less than or equal to 0, show an error:
“Amount must be greater than zero.”

If the Stage Name is ‘Closed Won’, then Probability should be 100 automatically.

If the Stage Name is ‘Closed Lost’, then Probability should be 0 automatically.*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Opportunity newOpp : Trigger.New){
            if(newOpp.amount == NULL || newOpp.Amount <= 0){
                newOpp.addError('Amount must be greater than zero');
            }
            if(newOpp.StageName == 'Closed Won'){
                newOpp.Probability = 100;
            }
            else if(newOpp.StageName == 'Closed Lost'){
                newOpp.Probability = 0;
            }
        }
    }
    
    /*When a new Opportunity is created or updated:

If CloseDate is in the past → throw an error: "Close Date cannot be in the past."

If Amount is greater than 500,000 → set Opportunity_Type__c = 'Big Deal'

If Amount is between 100,000 and 500,000 → set Opportunity_Type__c = 'Medium Deal'

If Amount is less than 100,000 → set Opportunity_Type__c = 'Small Deal'*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Opportunity newOpp : Trigger.New){
            if(newOpp.Amount > 500000){
                newOpp.Opportunity_Type__c = 'Big Deal';
            }
            else if(newOpp.Amount >= 100000 && newOpp.Amount <= 500000){
                newOpp.Opportunity_Type__c = 'Medium Deal';
            }
            else{
                 newOpp.Opportunity_Type__c = 'Small Deal';
            }
            if(newOpp.CloseDate != null && newOpp.CloseDate < Date.today()){
                newOpp.addError('Close Date cannot be in the past');
            }
        }
    }
      
}
