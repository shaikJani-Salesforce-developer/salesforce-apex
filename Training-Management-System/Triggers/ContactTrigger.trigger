trigger ContactTrigger on Contact (before insert,after insert,after update,after delete,before delete,After undelete,before update) {
/*
Whenever a Contact is INSERTED or UPDATED,
check if the Contact has Email.
If Email ≠ null
→ set Account.Has_Active_Contacts__c = true
→ set Account.Has_Active_Contacts__c = false*/
    if(Trigger.isAfter && (Trigger.isInsert ||Trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        for(Contact Contact :Trigger.new){
            if(contact.AccountId !=null){
                accountIds.add(contact.AccountId);
            }
        }
map<id,Account> accsMap = new map<id,Account>([select id,name,Has_Active_Contacts__c from account
                                                      where id IN:accountIds]);
        //set false as default value 
        for(Account account : accsmap.values()){
            account.Has_Active_Contacts__c =false;
        }
        //
        for(Contact contact :Trigger.new){
            if(contact.email !=null && accsMap.containsKey(contact.AccountId)){
                accsMap.get(contact.accountid).Has_Active_Contacts__c = true;
            }
        }
        update accsMap.values();
    }
    //cenario
/*Whenever a Contact is DELETED,
update Account.Total_Contacts__c with the current number of Contacts.*/
    if(Trigger.isAfter && Trigger.isDelete){
        set<id> accountids = new set<id>();
        for(Contact contact :Trigger.old){
            if(contact.AccountId !=null){
                accountIds.add(contact.AccountId);
            }
        }
        //Query the account records
       map<id,Account> accsMap = new map<id,Account>([select id,name,Total_Contacts__c,(select id,email from Contacts) from Account
                                                     where id IN:accountIds]);
        
        for(Account account : accsMap.values()){
            account.Total_Contacts__c = account.contacts.size();
        }
        update accsMap.values();
    }
    /*Whenever a Contact is INSERTED or UPDATED
For the related Account:

If the Account has at least 1 Contact with Email

👉 Set
Account.Is_Priority_Customer__c = true

Otherwise
👉 Set
Account.Is_Priority_Customer__c = false*/
    if(Trigger.isAfter && (Trigger.isinsert || Trigger.isUpdate)){
        //load parent account ids into set
        set<id> accountIds = new set<id>();
        for(Contact contact :Trigger.new){
            if(contact.AccountId !=null){
                accountIds.add(contact.accountid);
            }
        } 
        
            //fetch Account records 
 map<id,Account> accsMap = new map<id,Account>([select id,name,is_Priority_Customer__c from Account
                                               where id IN: accountIds]);
            
            //set the default value as false
            for(Account account : accsMap.values()){
                account.is_Priority_Customer__c = false;
            }
        
            for(Contact contact : Trigger.new){
                if(contact.email !=null && accsMap.containsKey(contact.accountid )){
                    accsMap.get(contact.accountid).Is_Priority_Customer__c = true;
                }
            }
            update accsMap.values(); 
        }
    
    /*Whenever a Contact is UPDATED:

If Email was NULL before

And Email is NOT NULL now

➡️ Set
Account.Has_Active_Contacts__c = true*/
    if(Trigger.isAfter && Trigger.isUpdate){
        set<id> accountIds = new set<id>();
        for(Contact contact : Trigger.new){
          Contact  oldContact = trigger.oldMap.get(contact.id);
       if(oldContact.Email==null && contact.email !=null && contact.AccountId !=null){
                accountIds.add(contact.AccountId);
            }
        }
        //fetch Account Records 
        map<id,Account> accsMap = new map<id,Account>([select id,name,Has_Active_Contacts__c from Account
                                                      where id IN:accountIds]);
     
        //update the logic 
        for(Account account : accsMap.values()){
            account.Has_Active_Contacts__c = true;
        }
        update accsMap.values();
    }
    /*Whenever a Contact is INSERTED or UPDATED:

If Phone is present
Set Account.Has_Contact_Phone__c = true*/
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        set<id> accountIds = new set<id>();
        for(Contact contact :Trigger.new){
            if(contact.AccountId !=null){
                accountIds.add(contact.AccountId);
            }
        }
        //fetch account records
        map<id,Account> accsMap = new map<id,Account>([select id,name,Has_Contact_Phone__c from Account
                                                      where id IN:accountIds]);
        
       
        
        for(Contact contact :Trigger.new){
            if(contact.Phone !=null && accsMap.containsKey(contact.AccountId)){
                accsMap.get(contact.AccountId).Has_Contact_Phone__c = true;
            }
        }
        update accsMap.values();
     } 
    /*Task 2 
Whenever a contact is inserted 
The parent Account object custom field should be populate
Update Account.Total_Contacts__c 
*/  
    if(Trigger.isAfter && Trigger.isInsert){
        set<id> accountIds = new set<id>();
        for(Contact contact : Trigger.new){
            if(contact.AccountId !=null){
                accountIds.add(contact.AccountId);
            }
        }
        map<id,Account> accsMap = new map<id,Account>([select id,name,Total_Contacts__c,(select id from contacts) from Account
                                                      where id IN:accountIds]);
        
        for(Account account :accsMap.values()){
            account.Total_Contacts__c = account.Contacts.size();
        }
        update accsMap.values(); 
    }
    //Prevent Contact deletion if related Cases exist”
  if(Trigger.isBefore && Trigger.isDelete){
        //load parent contact ids into set
        set<id> contactIds = new set<id>();
        for(Contact contact : Trigger.old){
           contactIds.add(contact.id);
        }
        //fetch Cases 
    set<id> contactsWithCases = new set<id>();
        for(Case C : [select contactId from Case where ContactId IN:contactIds]){
            contactsWithCases.add(c.contactid);
        }
        
        
    for(Contact contact : Trigger.old){
        if(contactsWithCases.contains(contact.Id)){
        contact.addError('Cannot delete Contact because related Case records exist');
      }
    }
  }  
    /* Update Account when Contact is deleted 
     On Contact deletion, decrement account.Total_Contacts__c*/
    if(Trigger.isAfter && Trigger.isDelete){
        set<id> accountIds = new set<id>();
        for(Contact contact : Trigger.old){
            if(contact.AccountId !=null){
                accountIds.add(contact.AccountId);
            }
        }
        // fetch Accounts into map
        map<id,Account> accsMap = new map<id,Account>([select id,name,Total_Contacts__c from Account
                                                      where id IN :accountIds]);
        
        for(Account account : accsMap.values()){
            if(account.Total_Contacts__c != null && account.Total_Contacts__c > 0){
                account.Total_Contacts__c -= 1;
            }
        }
        update accsMap.values();
    } 
    /*Whenever a Contact is created or deleted, update the parent Account field Contact_Strength__c as follows:

Strong → more than 5 Contacts

Medium → 2 to 5 Contacts

Weak → less than 2 Contacts*/
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isDelete)){
        set<id> accountIds = new set<id>();
        if(Trigger.isInsert){
            for(Contact contact :Trigger.new){
                if(contact.AccountId != null){
                    accountIds.add(contact.AccountId);
                }
            }
        }
        if(Trigger.isDelete){
            for(Contact contact :Trigger.old){
                if(contact.AccountId !=null){
                    accountIds.add(contact.AccountId);
                }
            }
        }
list<Account> accsList = new list<Account>([select id,name,Contact_Strength__c,
                  (select id from Contacts) from Account where id IN:accountIds]);
         for(Account account : accsList){
          Integer conCount  = account.Contacts.size();
            if(conCount >5){
                account.Contact_Strength__c = 'Strong';
            }
            else if(conCount >=2){
                account.Contact_Strength__c = 'Medium';
            }
            else{
                account.Contact_Strength__c = 'Low';
            }      
        }
       update accsList;
    }
   
/*Whenever a Contact is created, updated, or deleted,
check all Contacts under the parent Account.

If at least one Contact has
Email NOT null AND Phone NOT null
→ set Account.Customer_Engaged__c = true

If no Contact satisfies this condition
→ set Account.Customer_Engaged__c = false*/
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete)){
        set<id> accountIds = new set<id>();
        if(Trigger.isInsert || Trigger.isUpdate){
            for(Contact contact :Trigger.new){
                if(contact.accountid !=null){
                    accountIds.add(contact.AccountId);
                }
            }
        }
        if(Trigger.isDelete){
            for(Contact contact :Trigger.old){
                if(contact.AccountId !=null){
                    accountIds.add(contact.AccountId);
                }
            }
        }
        set<id> emailAndPhoneCons = new set<id>();
  for(Contact contact : [select id,Email,Phone,Accountid from Contact where accountId IN:accountIds]){
            if(contact.Email != null && contact.Phone !=null){
                emailAndPhoneCons.add(contact.AccountId);
            }
        }
  Map<id,Account> accsMap = new Map<id,Account>([select id,Name,Customer_Engaged__c from Account
                                                where id IN:accountIds]);
        
        for(Account account :accsMap.values()){
            if(emailAndPhoneCons.contains(account.Id)){
                account.Customer_Engaged__c = true;
            }
            else{
                account.Customer_Engaged__c = false;
            }
        }
        update accsMap.values();
    }
    //Rule : Two Contacts should not have the same Email.
    if(Trigger.isbefore && (Trigger.isInsert || Trigger.isUpdate)){
        set<String> emails = new set<String>();
        for(Contact contact :Trigger.new){
            if(contact.email !=null){
                emails.add(contact.Email);
            }
        }
         Map<String,id> existingEmailMap = new Map<String,id>();
        for(Contact contact :[select id,email from contact where email IN: emails]){
            existingEmailMap.put(contact.email, contact.Id);
        }
        for(Contact contact : Trigger.new){
            if(contact.email !=null && existingEmailMap.containsKey(contact.Email) &&
               contact.id != existingEmailMap.get(contact.email)){
                   contact.addError('Duplicate Contact Email is not allowed.');
               }
        }
    }
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
}
