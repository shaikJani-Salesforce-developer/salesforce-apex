trigger AccountTrigger on Account (before insert,before update,before delete,after Insert,after update,After delete,after undelete) {
/*When an Account is updated:
Look at ALL related Opportunities
Calculate the TOTAL Amount of Opportunities where:
StageName = 'Closed Won'
CloseDate is in the last 12 months

If:
Total Amount ≥ 10,00,000
👉 Set
Account.VIP_Customer__c = true

Else:
👉 Set
Account.VIP_Customer__c = false*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Account account :Trigger.new){
           accountIds.add(account.id);
        }
        
   Map<id,Decimal> totalOppsAmount = new Map<id,Decimal>();
   for(AggregateResult ar :[select accountId,SUM(Amount) amt from Opportunity where accountid IN:accountIds
                            And StageName = 'Closed Won' And CloseDate = Last_N_Months:12 Group By accountId]){
             
                   totalOppsAmount.put((id) ar.get('accountid'),(Decimal) ar.get('amt'));                               
                                                                                                  
        }
   Map<id,Account> accsMap = new Map<id,Account>([select id,name,Vip_Customer__c from Account 
                                                      where id IN:accountIds]); 
        
        for(Account account :accsMap.values()){
            if(totalOppsAmount.containsKey(account.id) && totalOppsAmount.get(account.id)>=1000000){
               account.VIP_Customer__c = true;
            }
            else{
                account.VIP_Customer__c = false;
            } 
        }
        update accsMap.values();
    }
     /*Account (After Update)

Count how many related Opportunities have StageName = 'Closed Won'

If count ≥ 3 → set Account.Premium_Customer__c = true

Else false*/
    if(Trigger.isAfter && Trigger.isUpdate){
    Set<Id> accountIds = new Set<Id>();
    for(Account acc : Trigger.new){
        accountIds.add(acc.Id);
    }

    Map<Id, Account> accsMap = new Map<Id, Account>(
        [SELECT Id, Premium_Customer__c,
                (SELECT Id FROM Opportunities WHERE StageName = 'Closed Won')
         FROM Account
         WHERE Id IN :accountIds]
    );

    for(Account acc : accsMap.values()){
        if(acc.Opportunities.size() >= 3){
            acc.Premium_Customer__c = true;
        } else {
            acc.Premium_Customer__c = false;
        }
    }

    update accsMap.values();
}
     /*Scenario:

When an Account is updated:
Check ALL related Opportunities
If ANY Opportunity has:
StageName = 'Closed Won'
AND Amount >= 1,00,000

👉 Set
Account.High_Value_Customer__c = true

Else
Account.High_Value_Customer__c = false*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Account account :trigger.new){
            accountIds.add(account.id);     
        }
        set<id> stageAndAmountOpps = new set<id>();
        for(Opportunity opportunity :[select id,name,stageName,Amount from Opportunity where accountid IN: accountids]){
            if(opportunity.StageName == 'Closed Won' && opportunity.Amount >=100000 && opportunity.AccountId !=null){
                stageAndAmountOpps.add(opportunity.AccountId);
            }
        }
        Map<id,Account> accsMap = new Map<id,Account>([select id,name,High_Value_Customer__c from Account
                                                       where id IN:accountIds]);
                                                           
                 for(Account account :accsMap.values()){
                     if(stageAndAmountOpps.contains(account.id)){
                         account.High_Value_Customer__c = true;
                     } 
                     else{
                         account.High_Value_Customer__c = false;
                     }                                                                                            
                  }
        update accsMap.values();
   }
     /*Whenever a new Account is created, 
update all related Opportunities by setting StageName = 'Prospecting'.*/
    
    if(Trigger.isAfter && Trigger.isInsert){
        //step 1 collect parent account ids into set collection
        set<id> accountIds = new set<id>();
        for(Account account :Trigger.new){
            accountIds.add(account.id);
        }
        //step 2 fetch opportunities related each account 
list<Opportunity> Opps = new list<Opportunity>([select id,name,stageName from Opportunity
                                                where accountid IN :accountIds]);
        for(Opportunity opportunity : Opps){
            opportunity.stagename = 'Prospecting';
        }
            if(!Opps.isEmpty()){
                update Opps;
            }
    }
     
    /*Whenever an Account is UPDATED,
update all related Opportunities’ CloseDate
to today’s date.*/
    if(Trigger.isAfter && Trigger.isUpdate){
        //collect parent ids into set collection
        set<id> accountIds = new set<id>();
        for(Account account : Trigger.new){
            accountIds.add(account.id);
        }
        //fetch account related all Opportunities 
list<Opportunity> oppsToUpdate = new list<Opportunity>(
 [select id,name,CloseDate from Opportunity where accountid IN:accountIds]);
        for(Opportunity opportunity :OppsToUpdate){
            opportunity.CloseDate = Date.today();
        }
        update oppsToUpdate;
    }
    /*Whenever Accounts are updated,
 check if any related Opportunity’s Amount > 50,000.
If yes → set Account.Has_Big_Opportunity__c = true
Otherwise → set Account.Has_Big_Opportunity__c = false */
    if(Trigger.isAfter && Trigger.isUpdate){
        //collect parent account ids into set
        set<id> accountIds = new set<id>();
        for(Account account : Trigger.new){
          accountIds.add(account.id);
            
        }
        //fetch accounts into map 
        map<id,Account> accsMap = new map<id,Account>([select id,name,Has_Big_Opportunity__c from Account where id IN:accountIds]);
        
        //fetch Account related opportunities into list
        list<Opportunity> oppsList = new list<Opportunity>([select id,name,Amount from Opportunity
                                                 where amount>50000 AND accountid IN:accountIds]);
          
        for(Opportunity opportunity : oppsList){
            if(accsMap.containsKey(opportunity.AccountId)){
                accsMap.get(opportunity.AccountId).Has_Big_Opportunity__c =  true;
            }
        }
        update accsMap.values();
    }
    /*Whenever an Account is UPDATED,
check all related Contacts.
If ANY Contact.Email is NOT null
→ set Account.Has_Active_Contacts__c = true
→ set Account.Has_Active_Contacts__c = false*/
    set<id> accountIds = new set<id>();
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Account account : Trigger.new){
            accountIds.add(account.id);
        }
        //fetch account records into map 
        map<id,Account> accsMap = new map<id,Account>([select id,name,Has_Active_Contacts__c from Account 
                                                      where id IN:accountIds]);
        //set false default value 
        for(Account account :accsMap.values()){
            account.Has_Active_Contacts__c = false;
        }
        //fetch Account related all contact records 
       list<Contact> consList = new list<Contact>([select id,email from Contact where accountid IN:accountIds]);
        
        for(Contact contact :consList){
            if(contact.email !=null && accsMap.containsKey(contact.AccountId)){
                accsMap.get(contact.AccountId).Has_Active_Contacts__c = true;
            }
        }
        update accsMap.values();
    }
    /*Whenever Accounts are updated, check if any related Opportunity Stage = 'Closed Won'.
If yes → set Account.Has_Closed_Won_Opportunity__c = true
Otherwise → set it to false.*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Account account :Trigger.new){
            accountIds.add(account.id);
        }
        //fetch accounts 
        map<id,Account> accsMap = new map<id,Account>([select id,Has_Closed_Won_Opportunity__c
                                                      from Account where id IN:accountIds]);
        //set false as a Default value
        for(Account account :accsMap.values()){
                account.Has_Closed_Won_Opportunity__c = false;       
        }
        //fetch account related opportunities
        list<Opportunity> oppsList = new list<Opportunity>([select id,name,StageName from Opportunity
                                                           where accountid IN:accountIds]);
        
        for(Opportunity opportunity : oppsList){
            if(opportunity.StageName =='Closed Won' && accsMap.containsKey(opportunity.AccountId)){
                accsMap.get(opportunity.AccountId).Has_Closed_Won_Opportunity__c = true;
            }
        }
        update accsMap.values();
    }
    /*Whenever Accounts are updated, check if any related Contact’s Title = 'Manager'.
If yes → set Account.Has_Manager_Contact__c = true
Otherwise → false.*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Account account :Trigger.new){
            accountIds.add(account.id);
        }
        //fetch Accounts
        map<id,Account> accsMap = new map<id,Account>([select id,name,Has_Manager_Contact__c from Account
                                                      where id IN:accountIds]);
        //set false value as default
        for(Account account : accsMap.values()){ 
            account.Has_Manager_Contact__c = false;
        }
        
        //fetch account related contacts
        list<Contact> consList = new list<Contact>([select id,Title from Contact where accountid IN:accountIds]);
        
        for(Contact contact : consList){
            if(contact.Title == 'Manager' && accsMap.containsKey(contact.accountid)){
                accsMap.get(contact.AccountId).Has_Manager_Contact__c = true;
            }
        }
        update accsMap.values();
    }
  //Do not allow Account deletion if it has at least one active Opportunity.
    if(Trigger.isBefore && Trigger.isDelete){
        set<id> accountIds = new set<id>();
        for(Account account : Trigger.old){
            accountids.add(account.id);
        }
          set<id> accountsWithOpps = new set<id>();
        for(Opportunity opportunity :[select accountid from Opportunity where accountid IN:accountIds
                                     AND StageName NOT IN ('Closed Won', 'Closed Lost')]){
            accountsWithOpps.add(opportunity.AccountId);
        }
        for(Account account : Trigger.old){
            if(accountsWithOpps.contains(account.id)){
                account.addError('Cannot delete Account record');
            }
        }
    }
 /* Parent → Child cascading update
Scenario: When Account.Status__c = 'Inactive' → 
Update all related Contacts to Active__c = false*/
    if(Trigger.isAfter && Trigger.isUpdate){
         set<id> accountIds = new set<id>();
        for(Account account :Trigger.new){
           Account oldAccount = Trigger.oldMap.get(account.id);
            if(oldAccount.status__c == 'Active' && account.Status__c == 'In Active'){
                accountIds.add(account.id);
            }
        }
        //fetch contacts into list
        list<Contact> consToUpdate = new list<contact>([select id,Active__c from Contact
                                                       where accountid IN:accountIds]);
        
        for(Contact contact :consToUpdate){
            contact.Active__c = false;
        }
        if(!consToUpdate.isEmpty()){
           //update consToUpdate;
        }
    }
    /*Whenever Accounts are updated,
 check if any related Opportunity’s Amount > 50,000.
If yes → set Account.Has_Big_Opportunity__c = true
Otherwise → set Account.Has_Big_Opportunity__c = false */
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Account account :Trigger.new){
            accountIds.add(account.id);
        }
         set<id> amountOpps = new set<id>();
        for(Opportunity opportunity :[select accountId,Amount from Opportunity where accountId IN:accountIds And Amount >50000]){
            if(opportunity.accountId !=null){
                amountOpps.add(opportunity.AccountId);
            }
        }
        list<Account> accountToUpdate = new list<Account>();
        for(Account account : Trigger.new){
            if(amountOpps.contains(account.id)){
                account.Has_Big_Opportunity__c = true;
            }
            else{
            account.Has_Big_Opportunity__c = false;
               
        }
             accountToUpdate.add(account);
        }
        update accountToUpdate;
    }
   /*Scenario:

When an Account is updated:
Check ALL related Opportunities
If ANY Opportunity has:
StageName = 'Closed Won'
AND Amount >= 1,00,000

👉 Set
Account.High_Value_Customer__c = true

Else
Account.High_Value_Customer__c = false*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Account account :trigger.new){
            accountIds.add(account.id);     
        }
        set<id> stageAndAmountOpps = new set<id>();
        for(Opportunity opportunity :[select id,name,stageName,Amount from Opportunity where accountid IN: accountids]){
            if(opportunity.StageName == 'Closed Won' && opportunity.Amount >=100000 && opportunity.AccountId !=null){
                stageAndAmountOpps.add(opportunity.AccountId);
            }
        }
        Map<id,Account> accsMap = new Map<id,Account>([select id,name,High_Value_Customer__c from Account
                                                       where id IN:accountIds]);
                                                           
                 for(Account account :accsMap.values()){
                     if(stageAndAmountOpps.contains(account.id)){
                         account.High_Value_Customer__c = true;
                     } 
                     else{
                         account.High_Value_Customer__c = false;
                     }                                                                                            
                  }
        update accsMap.values();
   }
    /*Account (After Update)

Count how many related Opportunities have StageName = 'Closed Won'

If count ≥ 3 → set Account.Premium_Customer__c = true

Else false*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Account account: Trigger.new){
            accountIds.add(account.id);
        }
        
        Map<id,Integer> closedWonCountOpps = new Map<id,Integer>();
        for(AggregateResult ar :[select count(id) cnt ,Accountid from Opportunity where accountId IN:accountIds 
                                    And StageName = 'Closed Won' Group By Accountid]){
            
                 closedWonCountOpps.put((id) ar.get('accountid'),(Integer) ar.get('cnt'));                      
        }
        Map<id,Account> accsMap = new Map<id,Account>([select id,name,Premium_Customer__c from Account 
                                                        where id IN:accountids]);
         
        for(Account account :accsMap.values()){
            if(closedWonCountOpps.containsKey(account.id) && closedWoncountOpps.get(account.id)>= 3){
                account.Premium_Customer__c = true;
            }
            else {
                account.Premium_Customer__c = false;
            }
        }
        update accsMap.values();
    }
    
         //Account record should not be deleted if the account active status = yes

    if(Trigger.isBefore && Trigger.isdelete){
        
        for(Account oldAc : Trigger.old){
            if(oldAc.active__c == 'Yes'){
                oldAc.addError('if status is yes this record cant be deleted');
            }
            
            
        }
    }
    /*When a new Account record is created or updated,
if the AnnualRevenue is greater than 1,000,000, automatically set Account Tier = ‘Platinum’.

If the AnnualRevenue is between 500,000 and 1,000,000, set Account Tier = ‘Gold’.

If the AnnualRevenue is less than 500,000, set Account Tier = ‘Silver’.

If the Industry field is blank, show an error:
“Industry is mandatory for all accounts.”*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        
        for(Account newAccount : Trigger.New){
            if(newAccount.AnnualRevenue > 1000000){
                newAccount.Account_Tier__c ='Platinum';
            }
           else if(newAccount.AnnualRevenue >= 500000 && newAccount.AnnualRevenue <= 1000000){
                newAccount.Account_Tier__c = 'Gold';
            }
            else {
                newAccount.Account_Tier__c ='Silver';
            }
            if(newAccount.Industry == NULL || newAccount.Industry ==''){
                newAccount.addError('Industry is mandatory for all accounts');
            }
            
        }
    }
    //whenever an account is created,create a related contact record
    if(Trigger.isAfter && Trigger.isInsert){
        list<Contact> contacts = new list<Contact>();
        for(Account account :Trigger.new){
            if(account.id != null){
            Contact contact = new Contact();
                contact.Salutation ='Mr';
            contact.FirstName = 'Rao';
            contact.LastName = 'Ramesh'+account.name;
            contact.Email = 'rao' + Math.random() + '@gmail.com';
            contact.Phone ='89076';
            contact.AccountId = account.Id;
                contact.LeadSource ='Web';
                contact.Description ='naku kavali';
                
            contacts.add(contact);
        }
        } 
        
                System.debug('Contacts to insert: ' +contacts);
               insert contacts;
            
            
            
    
    } 
    //whenever a account is created with rating hot ,create a related Opportunity
    if(Trigger.isAfter && Trigger.isInsert){
        list<Opportunity> opportunities = new list<Opportunity>();
        for(Account account : Trigger.new){
            if(account.Rating== 'Hot'){
            Opportunity opportunity = new Opportunity();
            opportunity.name = 'Lot Mobiles Business deal ' + account.name;
            opportunity.StageName = 'Closed Won';
                opportunity.AccountId = account.id;
            opportunity.CloseDate = Date.today().adddays(50);
            opportunity.Amount = 5000000;
            opportunity.LeadSource ='Web';
            opportunity.Probability = 100;
                opportunities.add(opportunity);
        }
    }
        
            insert opportunities;
         
        
    } 
    //Create a related opportunity, for the account record if the account do not have any related opportunities at the time of updating the account record
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Opportunity> opportunities = new List<Opportunity>();

        Map<Id, Account> accWithopps = new Map<Id, Account>(
            [SELECT Id, (SELECT Id FROM Opportunities) FROM Account]
        );

        for(Account account : Trigger.new){
            if(accWithopps.get(account.Id).Opportunities.size() == 0){
                Opportunity opportunity = new Opportunity();
                opportunity.Name = 'Business deal ' + account.Name;
                opportunity.StageName = 'Prospecting';
                opportunity.CloseDate = System.today();
                opportunity.AccountId = account.Id;
                opportunities.add(opportunity);
            }
        }
        insert opportunities;
    }

    
   //deleted records should goes into Account log object 
     if(Trigger.isAfter && Trigger.isdelete){
        list<Account_Log__c> aclog = new list<Account_Log__c>();
        for(Account account : Trigger.old){
            if(account.Id != null){
                Account_Log__c aclogs = new Account_Log__c();
                aclogs.name = account.name;
                aclogs.Deleted_By__c = UserInfo.getUseriD();
                aclogs.Deleted_On__c =system.now();
                aclog.add(aclogs);
            }
        }
        insert aclog;
    }
    /* Account record got deleted → 
     *bring that record back to Account object by updating the account name 
indicating that the account is restored from the recyclebin 
*/
    //collect restored accountids into set
    //trigger.new has restored accounts
    
    if(Trigger.isAfter && Trigger.isUndelete){
        set<Id> restoredAcs = new set<Id>();
        for(Account account : trigger.new){
            if(account.id !=null){
                restoredAcs.add(account.Id);
            }
        }
       list<Account> accountstoupdate = [select id,name from Account where id IN:restoredAcs];
        for(Account account : accountstoupdate){ 
            account.Name = 'Undeleted '+account.name;
        }
        update accountstoupdate;
    }
             
        
    
//Rule:

//When an Account’s Rating = 'Hot', set all related Contacts’ LeadSource = 'Referral'.
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> hotAcIds = new set<id>();
        for(Account account : Trigger.new){
            if(account.Rating == 'Hot'){
                hotAcIds.add(account.id);
            }
        }
        list<contact> cons = [select id,leadSource from Contact where accountid IN :hotAcIds];
        for(Contact contact :cons){
            contact.LeadSource = 'Referral';
        }
        update cons;
    }
    //Don’t allow deletion of Accounts with Industry = ‘Banking’.
    if(Trigger.isBefore && Trigger.isDelete){
        for(Account account:Trigger.old){
            if(account.industry == 'Banking'){
                account.addError('if Industry is Banking We Cannot delete ');
            }
        }
    }
}
