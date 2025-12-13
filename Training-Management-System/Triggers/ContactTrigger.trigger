trigger ContactTrigger on Contact (before insert,before update,after delete) {
/*When a new Contact record is created,
if the Lead Source field is blank,
then automatically set Lead Source = ‘Web’.

If the Description field is blank,
then automatically set Description = ‘Created automatically via trigger’.*/
    if(Trigger.isBefore && Trigger.isInsert){
        for(Contact newContact : Trigger.New){
            if(newContact.LeadSource == Null || newContact.LeadSource ==''){
                     newContact.LeadSource ='Web';
            }
            if(newContact.Description == Null || newContact.Description ==''){
            newContact.Description = 'Created automatically via trigger';
            } 
        } 
        
    }
    //whenever a related contact is deleted then delete the account record also
        //we cannot directly delete accountids in loop 
        //we can use set collection for avoiding duplicates
        //because 1 account have multiple childs
        
    if(Trigger.isAfter && Trigger.isdelete){
        set<id> accountIdstodelete = new set<Id>();
        for(Contact contact : Trigger.old){
            if(contact.accountId !=null){
                accountIdstodelete.add(contact.AccountId);
            }
        }
        //now fetch ids u want to delete
      list<Account> accsTodelete = [select id from Account where id IN:accountIdstodelete];
        delete accsTodelete;
    }
    
    /*Business Rule 1: Auto-copy Account’s Phone to new Contact
      Rule Logic:

    Whenever a new Contact is created,

    Copy its parent Account’s Phone number into the Contact’s Phone field automatically.*/
    if(Trigger.isBefore && Trigger.isInsert){
        set<id> consWithAccs = new set<id>();
        For(Contact contact : Trigger.new){
            if(contact.AccountId !=null){
                consWithAccs.add(contact.AccountId);
                
                
            }
          }
         map<id,Account> accMap = new map<id,Account>([select id,Phone from Account where id = :consWithAccs]);
        for(Contact contact : Trigger.new){
            if(contact.AccountId != null && accMap.containsKey(contact.AccountId)){
                contact.Phone = accMap.get(contact.AccountId).Phone;
            }
        }
        }
        /*When a Contact is inserted, if the Account’s Rating is “Hot”, automatically set the Contact’s Lead Source field to “Referral”*/
    if(Trigger.isBefore && Trigger.isInsert){
        set<id> accIds = new set<id>();
        for(Contact contact :Trigger.new){
            if(contact.AccountId != null){
                accIds.add(contact.AccountId);
      }
     }
        map<id,Account> accMap = new map<id,Account>([select id,Rating from Account where id=:accIds]);
        for(Contact contact : Trigger.new){
            if(contact.AccountId != null && accMap.get(contact.accountid).Rating == 'Hot'){
                contact.LeadSource = 'Referral';
            }
        }
        
    }
    /*When a Contact is inserted or updated:

If the related Account’s Rating = “Hot”, set Contact.LeadSource = “Referral”

If the related Account’s Industry = “Finance”, set Contact.Title = “Financial Advisor”*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        set<id> accIds = new set<id>();
        for(Contact contact :Trigger.new){
            if(contact.AccountId !=null){
                accIds.add(contact.AccountId);
            }
        }
        map<id,Account> accMap = new map<id,Account>([select id,Rating,Industry from Account where id =:accIds]);
        for(Contact contact : Trigger.new){
            if(contact.AccountId != null && accMap.get(contact.AccountId).Rating == 'Hot'){
                contact.LeadSource = 'Referral';
            }
            if(contact.AccountId !=null && accMap.get(contact.AccountId).Industry == 'Finance'){
                contact.Title = 'Financial Advisor';
            }
        }
    }
   //Whenever a Contact (child) is deleted, update a field in the Account (parent) to show the total number of contacts.
    if(Trigger.isAfter && Trigger.isDelete){
        // now collect all parent ids into set
        set<id> accsIds = new set<id>();
        for(Contact contact : Trigger.old){
            if(contact.accountid != null){
                accsIds.add(contact.accountid);
            }
        }
      map<id,Account> accsMap = new map<id,Account>([select id,Name,Number_Of_Contacts__c from Account where id = :accsIds]);
        for(Account account : accsMap.values()){
            integer contactCount = [select count() FROM Contact where accountid =:account.id];
            account.number_of_Contacts__c = contactCount;
        }
        update accsMap.values();
        }
        //Whenever a Contact is created, update the Account’s Rating field to "Hot" if at least one contact exists
    if(Trigger.isAfter && Trigger.isInsert){
        // collect parent ids in set
        set<id> accids = new set<id>();
        for(Contact contact : Trigger.new){
            if(contact.AccountId != null){
                accids.add(contact.AccountId);
            }
        }
        //query parent records 
        map<id,Account> accsToUpdate = new map<id,Account>([select id,name,Rating from Account where id = :accids]);
        //update parent records 
        for(Account account : accsToUpdate.values()){
            account.rating = 'Hot';
            }
        update accsToUpdate.values();
        }
    }
