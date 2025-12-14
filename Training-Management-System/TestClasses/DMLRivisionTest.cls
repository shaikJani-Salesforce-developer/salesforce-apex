@isTest
public class DMLRivisionTest {

    @isTest static void testdelete(){
        //before caling the method create a dummy record
        Case case1 = new Case();
             case1.Type = 'Electronic';
             case1.Reason = 'Breakdown';
             case1.Status = 'Closed';
             case1.Priority = 'High';
             case1.Origin ='Phone';
             case1.Product__c = 'GC1040';
             
              insert case1;
        Test.setCreatedDate(case1.Id, Date.today().addYears(-2));
        //now call the method & check this dummy record is deleted or not
        DMLRivision.updaterivision();
      Integer caseCount = [select count() from Case];
        System.assertEquals(0,caseCount);
        
        //before calling the method create a dummy record
        Account account1 = new Account();
         account1.name = 'Rupa Botique';
         account1.Industry = 'Banking';
         account1.Rating = 'Hot';
         account1.AnnualRevenue = 0;
         account1.NumberOfEmployees = 0;
         account1.phone = '90998';
         account1.Fax ='908';
         insert account1;
        //now call the method & check this dummy record is deleted or not
         DMLRivision.updaterivision();
     Integer acCount = [select count() from Account];
        System.assertEquals(0,acCount);
        
        //before calling the method create a dummy record
        Contact contact1 = new Contact();
        contact1.Salutation ='Mr';
        contact1.FirstName = 'Raju';
        contact1.LastName = 'Yadav';
        contact1.Department ='General';
        contact1.Email =null;
        contact1.Phone ='99999';
        contact1.Title ='Manager';
        insert contact1;
        //now call the method & check this dummy record deleted or not
        DMLRivision.updaterivision();
      Integer conCount = [select count() from Contact];
        System.assertEquals(0,conCount);

   //before calling method create a dummy record
       Book__c book1 = new Book__c();
        book1.name ='Mean';
        book1.Author_Name__c ='islam';
        book1.Price__c =700;
        insert book1;
        // now call the method check this dummy record deleted or not
       
         DMLRivision.booksdelete();
        Integer bookCount = [select count() from Book__c];
        System.assertEquals(0,bookCount);
    }
    
    @isTest static void testundeletebooks(){
        //step1 --> create a dummy record
        //step2 --> delete that dummy record
        //step --> call the method & check dummy record is undeleted or not
        
        Book__c book1 = new Book__c();
         book1.Name = 'Quran';
         book1.Author_Name__c = 'Allah';
         book1.Price__c = 1000;
        insert book1;
        
        delete book1;
        
        DMLRivision.undeletebooks();
       Integer bookCount = [select Count() from Book__c];
        System.assertEquals(1,bookCount);
        
    }
    @istest static void testinsertrevision(){
        DMLRivision.insertrevision();
     Integer acCount = [select count() from Account];
        System.assertEquals(1,acCount);
     Account ac =  [select id,Name from Account];
        System.assertEquals('BIG C Mobiles',ac.Name);
        
     Integer conCount  = [select count() from Contact];
        System.assertEquals(1,conCount);
     Contact con  = [select id,Name,Accountid from Contact where Accountid = :ac.id];
        System.assertEquals(ac.Id,con.AccountId);
        
        Integer caseCount = [select count() from Case];
        System.assertEquals(1,caseCount);
     Case case1 =  [select id,AccountId,ContactId from Case where AccountId =:ac.id and ContactId =:con.id];
        System.assertEquals(ac.Id,case1.AccountId); 
        System.assertEquals(con.id,case1.ContactId);
        
    } 
    @istest static void testupdaterevision(){
        
        //for update testing --> before calling the method create a dummy record
        Account account1 = new Account();
        account1.Name = 'Bhuvi Techno Solutions';
        account1.AnnualRevenue = 1100000;
        account1.Industry ='Technology';
        account1.NumberOfEmployees = 5000;
        account1.Rating = 'cold';
        account1.Phone ='89076';
        account1.Fax = '678';
        insert account1;
        //call the method &check this dummy record upvated or not
        DMLRivision.updaterivision();
      Account ac = [select id,Name,AnnualRevenue,Rating from Account where id = :account1.id];
        System.assertEquals('Hot',ac.Rating);
        
         Account account2 = new Account();
        account2.Name = 'Bh Techno Solutions';
        account2.AnnualRevenue = 40000;
        account2.Industry ='Technology';
        account2.NumberOfEmployees = 500;
        account2.Rating = 'Hot';
        account2.Phone = '78907';
        account2.Fax = '789';
        insert account2;
        DMLRivision.updaterivision();
      Account ac2  =[select id,Name,Rating,AnnualRevenue from Account where id = :account2.Id];
        System.assertEquals('Cold',ac2.Rating);
        
        //before calling the method create a dummy record 
         Account account4 = new Account();
        account4.Name = 'Galla Techno Solutions';
        account4.AnnualRevenue = 400000;
        account4.Industry ='Technology';
        account4.NumberOfEmployees = 600;
        account4.Rating = 'Hot';
        account4.Fax = '789';
        account4.Phone = '78908';
        insert account4;
        DMLRivision.updaterivision();
     Account ac4 = [select id,Name,Industry,NumberOfEmployees from Account where Id = :account4.Id];
        System.assertEquals('Enterprise',ac4.Industry);
        
        //before calling the method create dummy record
        Case case1 = new Case();
        case1.Priority = 'High';
        case1.Status ='New';
        case1.Origin ='Phone';
        case1.Reason = 'Installation';
        insert case1;
        
        // now call the method & check dummy record is updated or not
             DMLRivision.updaterivision();
       Case caseup = [select id,Status,Priority from Case where id = :case1.Id];
        System.assertEquals('In Progress',caseup.Status);
        
        //before calling method create a dummy record
          Case case2 = new Case();
        case2.Priority = 'Low';
        case2.Status ='New';
        case2.Origin ='Phone';
        case2.Reason = 'Installation';
        insert case2;
        // now call the method & check this dummy record is upvated or not
        DMLRivision.updaterivision();
      Case caseup2 = [select id,Status,Priority from Case where id = :case2.id];
        System.assertEquals('On Hold',caseup2.Status);
        
        
       
        
    }
    
   
}
