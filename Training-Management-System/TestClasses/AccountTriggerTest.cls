@istest
public class AccountTriggerTest {
 
   @istest static void testAccountInsert(){
        Account account = new Account();
       account.name = 'Roja Company limited';
       account.Industry = 'Banking';
       account.Phone = '45678';
       account.Fax = '245';
  
       insert account;
     Account Ac = [select id,name,Industry,Rating from Account where id =:account.id];
       System.assertEquals('Hot',Ac.Rating);
       
    }
    
    @istest static void testAccounts(){
        Account account = new Account();
        account.name = 'Sakshi Media Agency';
        
        try{
             insert account;
        System.assert(false,'Expected Error but Updated successfully');
          } catch(dmlException e){
                 System.assert(e.getMessage().contains('Enter Industry'));
                 } 
        
        Account account2 = new Account();
        account2.name = 'ABN Media Agency';
        account2.Industry ='Entertainment';
          
        try{
          insert account2;        
        System.assert(false,'Expected error but updated successfully');
        }catch(dmlException e){
            System.assert(e.getMessage().contains('Enter Phone'));
        }
        
             Account account1 = new Account();
        account1.name = 'Praise Ads Agency';
        account1.Industry ='Entertainment';
        account1.phone = '46678';
        
        try{
        insert account1;
        System.assert(false,'Expected error but inserted successfully');
        }catch(dmlException e){
            System.assert(e.getMessage().contains('Enter Fax'));
        }
        
        
        
    }
@istest static void testaccountdelete(){
        Account account1 = new Account();
         account1.name = 'Sudha Technos';
         account1.Active__c = 'Yes';
         account1.Rating = 'Hot';
         account1.Industry ='Banking';
         account1.Phone= '56789';
         account1.Fax = '246';
        insert account1;
    
  
    try{
    delete account1;
    System.assert(false,'expected error but deleted successfully');
    }catch(dmlException e){
        System.assert(e.getMessage().contains('if status is yes this record cant be deleted'));
    }
    }
    @istest static void testAccountAfterInsert(){
        //whenever an account is created,create a related contact record
            Account account1 = new Account();
            account1.name = 'Eenadu Media House';
            account1.Rating = 'Hot';
            account1.Industry ='Entertainment';
            account1.Phone = '24567';
            account1.Fax = '456';
            insert account1;
        // now fetch this account related contacts
        list<Account> accs = [select id,Name,rating,industry,(select id,firstName,lastname from Contacts) from Account Where id =:account1.Id];
        //chek how many accounts contacts are there 
        System.assertEquals(1,accs.size());
        System.assertEquals(1,accs[0].Contacts.size());
        System.assert(accs[0].contacts[0].lastname.contains('Eenadu Media House'));
        
    }
    @istest static void testOpp(){
         //whenever a account is created with rating hot ,create a related Opportunity
         Account account = new Account();
        account.name = 'Aparna Cyber cafe';
        account.Rating = 'Hot';
        account.Industry = 'Technology';
        account.Phone = '45678';
        account.Fax = '456';
        Insert account;
        //fetch account related opportunities
       list<Account> acc = [select id ,name,rating,industry,(select id,name,stagename,closedate from Opportunities) from Account where id =:account.id];
        System.assertEquals(1,acc.size());
        System.assertEquals('Hot',acc[0].rating);
        System.assertEquals(1,acc[0].opportunities.size());
        System.assert(acc[0].opportunities[0].name.contains('Aparna Cyber cafe'));
    }
   @istest static void testAfterUpdate(){
 //Create a related opportunity, for the account record if the account do not have any related opportunities at the time of updating the account record
        //step 1 create a dummy Account
        //step 2 update that dummy account to fire after update trigger
        //step 3 fetch related opportunities
       Account account = new Account();
       account.name = 'Usha Fans';
       account.Rating = 'Warm';
       account.Industry = 'Electronics';
       account.Phone = '25678';
       account.Fax = '256';
       insert account;
       //update that dummy account to fire after update trigger
     Account acc = [select id,name,Phone,Industry,Rating from Account where id =:account.Id];
       acc.phone = '12456';
       update acc;
       //fetch related opportunities
      list<Account> accs =[select id,name,industry,rating,(select id,Name,StageName,CloseDate from Opportunities) from Account where id = :acc.id];
       System.assertEquals(1,accs.size());
       System.assertEquals(1,accs[0].Opportunities.size());
       System.assert(accs[0].Opportunities[0].name.contains('Usha Fans'));
       System.assertEquals('Prospecting',accs[0].Opportunities[0].StageName);
       System.assertEquals(account.id,accs[0].Opportunities[0].Accountid);
    }
    
   @istest static void testAfterdelete(){
       //deleted records should goes into Account log object 
       Account account = new Account();
        account.name = 'Bharathi Cements';
        account.Rating = 'Hot';
        account.Industry = 'Manufacturing';
       account.Phone = '24567';
       account.Fax ='678';
       insert account;
       
     Account acc = [select id,name,industry,rating from Account where id =:account.Id];
       delete acc;
       //fetch Account_Log__c records
    list<Account_Log__c> log  = [Select id,name,Deleted_By__c,Deleted_On__c from Account_Log__c where Name = 'Bharathi Cements'];
       System.assertEquals(1,log.size());
       System.assertEquals('Bharathi Cements',log[0].Name);
    }
    
    
    @istest static void testAfterUndelete(){
        /* Account record got deleted → 
     *bring that record back to Account object by updating the account name 
indicating that the account is restored from the recyclebin 
*/
        Account account = new Account();
        account.name = 'Raja tech Solutions';
        account.Rating ='Hot';
        account.Industry = 'Technology';
        account.Phone ='24567';
        account.Fax ='456';
        insert account;
        
       
        delete account;
        Undelete account;
        //fetch restored  record
        Account restoredAc = [select id,name,rating,Industry from Account where id =:account.id];
        System.assert(restoredAc.name.contains('Undeleted'));
        
        
    }
    @istest static void testAccountTier(){
        Account account = new Account();
        account.Name = 'Ramnath Technos';
        account.Industry = 'Technology';
        account.Phone ='67890';
        account.Fax = '567';
        account.Rating ='Hot';
        account.AnnualRevenue = 1100000;
        insert account;
    Account acc   = [select id,name,AnnualRevenue,Account_Tier__c from Account where id =:account.Id];
        System.assertEquals('Platinum',acc.Account_Tier__c);
        
        Account account1 = new Account();
        account1.Name = 'Roja Technos';
        account1.Industry = 'Technology';
        account1.Phone ='60890';
        account1.Fax = '267';
        account1.Rating ='Hot';
        account1.AnnualRevenue = 1000000;
        insert account1;
    Account acc1   = [select id,name,AnnualRevenue,Account_Tier__c from Account where id =:account1.Id];
        System.assertEquals('Gold',acc1.Account_Tier__c);
        
        Account account2 = new Account();
        account2.Name = 'Rp Technos';
        account2.Industry = 'Technology';
        account2.Phone ='65890';
        account2.Fax = '257';
        account2.Rating ='Hot';
        account2.AnnualRevenue = 400000;
        insert account2;
    Account acc2   = [select id,name,AnnualRevenue,Account_Tier__c from Account where id =:account2.Id];
        System.assertEquals('Silver',acc2.Account_Tier__c);
        
        //show error when industry is blank 
        Account account4 = new Account();
        account4.Name = 'Supriya hindu Technos';
        account4.Industry = 'Technology';
        account4.Phone ='65890';
        account4.Fax = '257';
        account4.Rating ='Hot';
        account4.AnnualRevenue = 400000;
        insert account4;
        
      Account acc4 = [select id,name,Industry,rating from Account where id =:account4.Id];
            acc4.Industry = NULL;
        try{
           update acc4;
           System.assert(false,'Expected error but updated successfully');
        }catch(dmlException e){
            system.assert(e.getMessage().contains('Industry is mandatory for all accounts'));
        }
    }
 @istest static void testupContact(){
        Account account = new Account();
        account.Name = 'Jani  Technos';
        account.Industry = 'Technology';
        account.Phone ='67891';
        account.Fax = '561';
        account.Rating ='Warm';
        account.AnnualRevenue = 1100000;
        insert account;
     
       Contact contact = new Contact();
     contact.Salutation = 'Ms';
     contact.FirstName = 'Rose';
     contact.lastname = 'Rani';
     contact.accountid = account.Id;
     insert contact;
     
     account.Rating = 'Hot';
     update account;
    list<Contact> cons = [select id,Leadsource,accountid from Contact where accountid =:account.id];
     System.assertEquals('Referral',cons[0].LeadSource);
    }
}
