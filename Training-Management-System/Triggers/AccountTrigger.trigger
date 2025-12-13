trigger AccountTrigger on Account (before insert,before update,before delete,after Insert,after update,After delete,after undelete) {
//Update the account rating to hot if the industry is banking 

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
     
        //this is logic less trigger - best practice 
        AccountTriggerHandler.beforeinsert(Trigger.new);
    }
    //Account industry,Fax,Phone is must
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
       //list<Account> newAccounts = Trigger.New;
        //this is logic less trigger - best practice
        AccountTriggerHandler.validationError(Trigger.new);
        
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
