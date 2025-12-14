@istest
public class RelationshipQueriesTest {
    @istest static void testRelationship(){
          //Fetch Accounts whose Name starts with S, then update all related Contacts' Title field to "Updated by SOQL Task".

        Account account = new Account();
        account.name = 'Sobert infra Solutions';
        account.Rating = 'Hot';
        account.Industry = 'Technology';
        account.Phone ='23456';
        account.Fax ='345';
        account.AnnualRevenue = 900000;
        insert account;
        
            Contact contact = new Contact();
            contact.Salutation = 'Mr';
            contact.FirstName = 'Uday';
            contact.LastName = 'Chopra';
            contact.Email = 'uday@gmail.com';
            contact.AccountId = account.Id;
            contact.Phone = '34567';
            insert contact;
            
        
        RelationshipQueries.SOQL4();
        list<Account> accs = [select id,name,rating,industry,(select id,firstname,lastname,Title from Contacts) from Account where id=:account.id];
        System.assertEquals('Update By SOQL task',accs[0].contacts[0].Title);
    }
    @istest static void testChatgpttasks(){
        Account account = new Account();
        account.name = 'Big C Mobiles';
        account.Rating = 'Hot';
        account.Industry ='Entertainment';
        account.Phone = '34567';
        account.Fax = '234';
        account.Has_Indian_Contact__c = False;
        insert account;
        
        Contact contact = new Contact();
        contact.Salutation = 'Mr';
        contact.FirstName = 'Raju';
        contact.LastName = 'Kumar';
        contact.AccountId = account.id;
        contact.MailingCountry__c = 'India';
        contact.Email = 'raju@gmail.com';
        contact.Phone = '34567';
        insert contact;
        RelationshipQueries.Chatgpttasks();
        list<Account> accs = [select id,name,Has_Indian_Contact__c,(select id,firstname,lastname,MailingCountry__c from Contacts) from Account where id =:account.id];
        System.assertEquals(true,accs[0].Has_Indian_Contact__c);
        
        Account account1 = new Account();
        account1.name = 'Lot Mobiles';
        account1.Rating = 'Hot';
        account1.Industry ='Entertainment';
        account1.Phone = '34567';
        account1.Fax = '234';
        account1.Has_Contact_Without_Email__c = False;
        insert account1;
        
        Contact contact1 = new Contact();
        contact1.Salutation = 'Mr';
        contact1.FirstName = 'Rajesh';
        contact1.LastName = 'Kumar';
        contact1.AccountId = account1.id;
       
        contact1.Email =Null;
        contact1.Phone = '34567';
        insert contact1;
        RelationshipQueries.Chatgpttasks();
        list<Account> accs1 = [select id,name,Has_Contact_Without_Email__c,(select id,firstname,lastname,Email from Contacts) from Account where id =:account1.id];
        System.assertEquals(true,accs1[0].Has_Contact_Without_Email__c);
        
    }
    
        @isTest static void testAccountOpp() {

        // Step 1: Delete all existing Accounts (only in test context)
        // so no unwanted old records disturb results
        // Clears existing Accounts (test data isolation).
        delete [SELECT Id FROM Account];

        // Step 2: Create first Account with big opportunity (Hot)
        Account acc1 = new Account(Name='RX Mobiles', Rating='Cold', Industry='Entertainment',Phone ='34567',Fax ='678');
        insert acc1;

        Opportunity opp1 = new Opportunity(
            Name='Business Deal 1',
            Amount=600000,
            AccountId=acc1.Id,
            CloseDate=Date.today(),
            StageName='Prospecting'
        );
        insert opp1;

        // Step 3: Create second Account with medium opportunity (Warm)
        Account acc2 = new Account(Name='Android Mobiles', Rating='Cold', Industry='Entertainment',Phone='56789',Fax='789');
        insert acc2;

        Opportunity opp2 = new Opportunity(
            Name='Deal 2',
            Amount=300000,
            AccountId=acc2.Id,
            CloseDate=Date.today(),
            StageName='Qualification'
        );
        insert opp2;
           
            Account acc3 = new Account(Name='Jio Mobiles', Rating='Warm', Industry='Entertainment',Phone='55789',Fax='789');
        insert acc3;
            
            Opportunity opp3 = new Opportunity(
            Name='Deal 3',
            Amount=100000,
            AccountId=acc3.Id,
            CloseDate=Date.today(),
            StageName='Qualification'
                
        );
            insert opp3;

        // Step 4: Run your main method
        RelationshipQueries.Chatgpttasks();

        // Step 5: Check results
        Account acc1Check = [SELECT Rating FROM Account WHERE Id=:acc1.Id];
        System.assertEquals('Hot', acc1Check.Rating);

        Account acc2Check = [SELECT Rating FROM Account WHERE Id=:acc2.Id];
        System.assertEquals('Warm', acc2Check.Rating);
            
            Account acc3Check = [SELECT Rating FROM Account WHERE Id=:acc3.Id];
        System.assertEquals('Cold', acc3Check.Rating);
    }
    @istest static void testContact(){
        Account account = new Account();
        account.Name = 'Suma Techs';
        account.Rating = 'Hot';
        account.Industry = 'Technology';
        account.Phone ='67890';
        account.Fax ='678';
        account.Has_Contact_Without_Phone__c = false;
        insert account;
        
        Contact contact = new Contact();
        contact.Salutation = 'Mr';
        contact.FirstName = 'Suraj';
        contact.lastname ='Kumar';
        contact.Phone = NULL;
        contact.AccountId = account.id;
        contact.Email = 'Suraj@gmail.com';
        insert contact;
        RelationshipQueries.Chatgpttasks();
        list<Account> accList =[select id,name,Has_Contact_Without_Phone__c from Account where id=:account.id];
        System.assertEquals(true,accList[0].Has_Contact_Without_Phone__c);
    }   
   @istest static void testAcc(){
        Account account = new Account();
        account.Name = 'Jai Techs';
        account.Rating = 'Hot';
        account.Industry = 'Banking';
        account.Phone ='67895';
        account.Fax ='673';
       insert account;
       
       Contact contact = new Contact();
        contact.Salutation = 'Ms';
        contact.FirstName = 'Seetha';
        contact.lastname ='Kumari';
        contact.Phone = '67890';
        contact.AccountId = account.id;
        contact.Email = 'Seetha@gmail.com';
        contact.Is_Banking_Contact__c = false;
        insert contact;
       
       Account account1 = new Account();
        account1.Name = 'Veera Techs';
        account1.Rating = 'Hot';
        account1.Industry = 'Technology';
        account1.Phone ='67890';
        account1.Fax ='670';
       insert account1;
       
       Contact contact1 = new Contact();
        contact1.Salutation = 'Ms';
        contact1.FirstName = 'Devi';
        contact1.lastname ='Kumari';
        contact1.Phone = '67878';
        contact1.AccountId = account1.id;
        contact1.Email = 'devika@gmail.com';
        contact1.Is_Banking_Contact__c = true;
        insert contact1;
       
       
       RelationshipQueries.Chatgpttasks();
       list<contact> cons = [select id,name,Is_Banking_Contact__c,Account.id,Account.name,Account.Industry from Contact where id=:contact.id];
       System.assertEquals(true,cons[0].Is_Banking_Contact__c);
       list<contact> cons1 = [select id,name,Is_Banking_Contact__c,Account.id,Account.name,Account.Industry from Contact where id=:contact1.id];
       System.assertEquals(false,cons1[0].Is_Banking_Contact__c);
    }
    @isTest
    static void testOppMethod() {
        // Insert one Opportunity with CloseDate within next 15 days
        Opportunity opp = new Opportunity(
            Name = 'Simple Test Opp',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(5),
            Amount = 90000
        );
        insert opp;
        
        Test.startTest();
        RelationshipQueries.Opp();
        Test.stopTest();
        
        // Re-query to check updates
        Opportunity updatedOpp = [SELECT StageName FROM Opportunity WHERE Id = :opp.Id];
        System.debug('After Method: ' + updatedOpp.StageName);
        System.assertEquals('Negotiation/Review', updatedOpp.StageName,
            'Stage should be updated to Negotiation/Review');
    }
    @isTest
static void testAccOppUpdate() {
    // Create Account
    Account acc = new Account(Name = 'Ravi Bank',Industry = 'Banking',Phone = '45678',Fax='678');
    insert acc;
    
    // Insert Opportunity (trigger changes StageName to Prospecting)
    Opportunity opp = new Opportunity(
        Name = 'Test Opp',
        CloseDate = Date.today().addDays(5),
        StageName = 'Prospecting',
        Amount = 900000,
        AccountId = acc.Id
    );
    insert opp;

    // Now manually update StageName to Closed Won (trigger won't fire again in before insert)
    opp.StageName = 'Closed Won';
    update opp;

    // Call your method
    RelationshipQueries.accOpp();

    // Verify Account updated
    Account updatedAcc = [SELECT Type FROM Account WHERE Id = :acc.Id];
    System.assertEquals('Active Customer', updatedAcc.Type);
}
}
