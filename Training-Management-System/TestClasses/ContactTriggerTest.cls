@isTest
public class ContactTriggerTest {
    @istest static void testContacttrigger(){
        /*When a new Contact record is created,
if the Lead Source field is blank,
then automatically set Lead Source = ‘Web’.

If the Description field is blank,
then automatically set Description = ‘Created automatically via trigger’.*/
        //Create a dummy contact
        Contact contact = new Contact();
        contact.Salutation ='Mr';
        contact.FirstName = 'Fahad';
        contact.LastName = 'Fasil';
        contact.Email ='Fahad@gmail.com';
        contact.Phone = '678';
        contact.LeadSource = NULL;
        contact.Description = NULL;
        insert contact;
      Contact upcontact = [select id,firstname,lastname,LeadSource,Description from Contact where id =:contact.id];
        System.assertEquals('Web',upcontact.LeadSource);
        System.assertEquals('Created automatically via trigger',upcontact.Description);
        
        //whenever a related contact is deleted then delete the account record also
        //step1 insert account
        //step2 insert related contact
        //delete related contact
        Account account = new Account();
        account.name ='Abhi technos';
        account.Rating = 'Hot';
        account.Industry ='Technology';
        account.Phone ='34567';
        account.Fax = '345';
        insert account;
        if(account.id != null){
            Contact contact1 = new Contact();
        contact1.Salutation ='Mr';
        contact1.FirstName = 'Mohan';
        contact1.LastName = 'Lal';
        contact1.AccountId = account.Id;
        contact1.Email ='Mohan@gmail.com';
        contact1.Phone = '689';
        contact1.LeadSource = 'Web';
        contact1.Description = 'Naku Kavali';
        insert contact1;
            delete contact1;
        }
        
        
        //now related account also deleted check account is deleted or not
        //fetch account from recycle bin
        list<Account> acc = [select id,name,IsDeleted from Account where id=:account.id ALL Rows];
        System.assertEquals(true,acc[0].IsDeleted);
        //expected value its deleted true 
              
    }
    @istest static void testContactPhone(){
        Account account = new Account();
        account.Name = 'Raheem Solutions';
        account.Phone = '12345';
        account.Rating = 'Hot';
        account.Industry = 'Technology';
        account.Fax = '678';
        insert account;
        
        Contact contact = new Contact();
        contact.Salutation ='Mr';
        contact.FirstName = 'Hamsa';
        contact.LastName = 'Kumar';
        contact.Email ='Hamsa@gmail.com';
        contact.LeadSource = 'Web';
        contact.AccountId = account.id;
     
        insert contact;
        list<Contact> cons = [select id,Phone from Contact where Accountid =:account.id];
        System.assertEquals('12345',cons[0].Phone);
        
        
        
        
    }
   @istest static void testCon(){
        Account account = new Account();
        account.Name = 'Raw Solutions';
        account.Phone = '12346';
        account.Rating = 'Hot';
        account.Industry = 'Technology';
        account.Fax = '678';
        insert account;
        
        Contact contact = new Contact();
        contact.Salutation ='Mr';
        contact.FirstName = 'Rama';
        contact.LastName = 'Chandra';
        contact.Email ='chandra@gmail.com';
        contact.AccountId = account.id;
     
        insert contact;
       list<Contact> cons = [select id,LeadSource from Contact where accountid =:account.id];
       System.assertEquals('Referral',cons[0].Leadsource);
       
       
    }
   @istest static void testContactTitle(){
        Account account = new Account();
        account.Name = 'Lathika Solutions';
        account.Phone = '12340';
        account.Rating = 'Hot';
        account.Industry = 'Technology';
        account.Fax = '678';
        insert account;
       
       Contact contact = new Contact();
        contact.Salutation ='Mr';
        contact.FirstName = 'Lokah';
        contact.LastName = 'Kotha';
        contact.Email ='kotha@gmail.com';
        contact.AccountId = account.id;
       insert contact;
       
       list<Contact> cons = [select id,LeadSource from Contact where accountid = :account.Id];
       System.assertEquals('Referral',cons[0].LeadSource);
       
       Account account1 = new Account();
        account1.Name = 'OSIT Solutions';
        account1.Phone = '12341';
        account1.Rating = 'Hot';
        account1.Industry = 'Finance';
        account1.Fax = '678';
        insert account1;
       
       Contact contact1 = new Contact();
        contact1.Salutation ='Mr';
        contact1.FirstName = 'Harish';
        contact1.LastName = 'Nath';
        contact1.Email ='Harish@gmail.com';
        contact1.AccountId = account.id;
       insert contact1;
       
       list<Contact> cons1 = [select id,Title from Contact where accountid = :account1.Id];
       System.assertEquals('Financial Advisor',cons1[0].Title);
    }
}
