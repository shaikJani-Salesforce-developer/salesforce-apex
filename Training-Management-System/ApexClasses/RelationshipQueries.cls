public class RelationshipQueries {
   public static void SOQL4(){      
        //Task 1: Update Contact’s Title if Account starts with 'S'
  //Fetch Accounts whose Name starts with S, then update all related Contacts' Title field to "Updated by SOQL Task".
    
    list<Account> accountsList = [select id,Name,Rating,Industry,(select id,Title from Contacts)from Account where Name Like 'S%'];
        list<Contact> contacts = new list<Contact>();// this empty list add contacts to this list
        if(!accountsList.isEmpty()){
            for(Account account :accountsList){
                for(Contact contact:account.contacts){
                    
                    contact.Title = 'Update By SOQL task';
                    contacts.add(contact); // aded each contact to the list
                }
            }
            update contacts;
        }
         
    }  

    
      public static void Chatgpttasks(){
        
        //For all Accounts, check if any related Contact’s MailingCountry = 'India'.
     //If yes, update a custom checkbox field on Account called Has_Indian_Contact__c to true
        
     list<Account> accList = [select id,Name,Rating,Industry,Has_Indian_Contact__c,(select id,mailingcountry__c from Contacts) from Account];
          list<Account> updateAccounts = new list<Account>();
          if(!accList.isEmpty()){
              
              for(Account account:accList){
                  account.Has_Indian_Contact__c = false;
                  for(Contact contact :account.contacts){
                      if(contact.MailingCountry__c =='India'){
                          account.Has_Indian_Contact__c = true;
                      }
                      
                      
                      
                  }
                  
                  
                    updateAccounts.add(account);                  
              } 
              update updateAccounts;
              
          }
          
          /*For all Accounts, check if any related Contact has no Email (i.e., Email field is blank).
If yes, update a custom checkbox field on Account called Has_Contact_Without_Email__c to true.
If all Contacts under that Account have Email values, set it to false.*/
          
        list<Account> accList1  =[select id,Name,Rating,Industry,Has_Contact_Without_Email__c,(select id,Email from Contacts) from Account];
          list<Account> updateAccounts1 = new list<Account>();
          if(!accList1.isEmpty()){
              for(Account account:accList1){
                  account.Has_Contact_Without_Email__c = false; // taking default false value
                  for(Contact contact:account.contacts){
                      if(contact.Email == null){
                        account.Has_Contact_Without_Email__c = true;
                     }
                
                 }
                  updateAccounts1.add(account);
              } 
              update updateAccounts1;
          }
          
          /*Scenario:
For each Account, check all its related Opportunities.
If the total Amount of all Opportunities under an Account is greater than 500,000, update the Account’s Rating field to “Hot”.
Otherwise, set it to “Warm”*/
         list<Account> accRecords = [select id,Name,Rating,Industry,(select id,Name,Amount from Opportunities) from Account];
          // this fetches each account related all opportunities
          List<Account> upAccs = new list<Account>();
          if(!accRecords.isEmpty()){
              for(Account account :accRecords){
                  Decimal totalAmount = 0; 
                  for(Opportunity opportunity :account.opportunities){
                      if(opportunity.Amount !=null){
                          totalAmount = totalAmount + opportunity.Amount;
                      }
                    }   
                               
                  if(totalAmount > 500000){
                      account.Rating = 'Hot';
                  }
                  else if(totalAmount >= 300000 && totalAmount <= 500000){
                      account.Rating = 'Warm';
                  }
                  else{
                      account.Rating = 'Cold';
                  }
                  upAccs.add(account);
              }
             update upAccs;
          } 
          
          /*For each Account, check all its related Contacts.
If any Contact’s Phone is blank (null), update a custom checkbox field on Account called Has_Contact_Without_Phone__c to true.
If all Contacts have Phone numbers, set it to false.*/
        list<Account> accAccounts = [select id,Name,Rating,Industry,Has_Contact_Without_Phone__c,(select id,Phone from Contacts)from Account];
             list<Account> accs = new list<Account>();                                                                   // Account has three contacts          
          if(!accAccounts.isEmpty()){                                          // Account                     contact
              for(Account account:accAccounts){                                //      A                        89009888
                  account.Has_Contact_Without_Phone__c = false;
                  for(Contact contact:account.contacts){                       //                                  null    
                      if(contact.Phone == null){                                //                              8008840960 
                          account.Has_Contact_Without_Phone__c = true;
                      }
                  } 
                  
                  accs.add(account);
                  
              }
              update accs;
          
      } 
     
          
      
          
          /*For each Contact, check if the related Account’s Industry is "Banking".
If yes, update the Contact’s custom checkbox field Is_Banking_Contact__c to true.
Otherwise, set it to false*/
         list<Account> acRecords = [select id,Name,Rating,Industry,(select id,Is_Banking_Contact__c from Contacts) from account];
          list<Contact> upContacts = new list<Contact>();
          if(!acRecords.isEmpty()){
              for(Account account:acRecords){
                  for(Contact contact:account.contacts){
                     
                  if(account.Industry == 'Banking'){
                      contact.Is_Banking_Contact__c = true;
                      
                  }
                      else {
                          contact.Is_Banking_Contact__c = false;
                      }
                  upContacts.add(contact); 
              }
          }
              update upContacts;
              //How to remember:

//If the field is about the whole parent (Account depends on all Contacts) → use default value.
//If the field is about the same record being checked directly → you can use else.
          } 
          
          /*Task
For each Opportunity, check its related Account’s Industry.
If the Industry is "Banking", update a custom picklist field on Opportunity called Opportunity_Category__c to "Banking Deal".
Otherwise, set it to "General Deal"*/
       list<Account> acRecs  = [select id,Name,Rating,Industry,(select id,Opportunity_cate__c from opportunities)from Account];
          list<Opportunity> upopps = new list<Opportunity>();
          if(!acRecs.isEmpty()){
              for(Account account:acRecs){
                  for(Opportunity opportunity : account.opportunities){
                      if(account.Industry == 'Banking'){
                          opportunity.Opportunity_cate__c = 'Banking Deal';
                      }
                      else{
                          opportunity.Opportunity_cate__c = 'General Deal';
                      }
                      upopps.add(opportunity); 
                     }
                  
              }
              update upopps;
          }
          
      }  
    public static void Opp(){
        
        /*For each Opportunity,
if the CloseDate is within the next 15 days
and the StageName is not “Closed Won” or “Closed Lost”,
update StageName to “Negotiation/Review”.
Otherwise, do nothing. */
        list<Opportunity> opps = [select id,name,stagename,closedate from Opportunity];
        list<Opportunity> upOpps = new list<Opportunity>();
        for(Opportunity opp:opps){
            if(opp.CloseDate < Date.today().adddays(15) && opp.stagename !='Closed Won'&& opp.stagename !='Closed Lost'){
                opp.stagename = 'Negotiation/Review';
                upOpps.add(opp);
            }
            
        }
        if(!upOpps.isEmpty()){
        update upOpps;
    } 
    }
    public static void accOpp(){
        /*Task:
For each Account, check all its related Opportunities.
If any Opportunity has StageName = 'Closed Won', update the Account’s Type field to "Active Customer".
If none of the Opportunities is 'Closed Won', set the Account’s Type field to "Prospect".*/
          
        List<Account> accAndOpps = [
            SELECT Id, Name, Type,
                   (SELECT Id, Name, StageName FROM Opportunities)
            FROM Account
        ];

        for (Account account : accAndOpps) {
            // default type
            account.Type = 'Prospect';

            for (Opportunity opportunity : account.Opportunities) {
                if (opportunity.StageName == 'Closed Won') {
                    account.Type = 'Active Customer';
                    break; // stop checking more opportunities
                }
            }
        }

        update accAndOpps;
          
    }
}
