@isTest
public class UpdateOperationTest {
    @isTest static void testupdate(){
    
        //before calling the method create dummy record
        Book__c book1 = new Book__c();
        book1.Name = 'Raavan';
        book1.Author_Name__c = 'Joseph';
        book1.Price__c = 500;
        Insert book1;
        //now call the methods /check this record is updated or not
        UpdateOperation.updatingrecords();
     Book__c book =  [Select id,Name,Price__c from Book__c where Id = :book1.Id];
        System.assertEquals(1500,book.Price__c);
    
        //before calling the method create a dummy record
         Account account1 = new Account();
         account1.Name = 'Manappuram Gold Loan';
         account1.Industry ='Banking';
         account1.Rating = 'Hot';
         account1.AnnualRevenue = 50000000;
         account1.NumberOfEmployees = null;
        
        insert account1;
        //now call the method & check this record is updated or not
        UpdateOperation.updatingAccountsrecords();
      Account acc =  [select id,Name,NumberOfEmployees from Account Where id = :account1.Id];
        System.assertEquals(550,acc.NumberOfEmployees);
        
        // now test else logic / for that create dummy record
        Account account2 = new Account();
         account2.Name = 'Himaja Textiles';
         account2.Industry = 'Banking';
         account2.Rating = 'Hot';
         account2.NumberOfEmployees = 500;
         insert account2;
        
        // now call the method // check this record is updated or not
         UpdateOperation.updatingAccountsrecords();
     Account acc2 =  [select id,Name,NumberOfEmployees from Account where id = :account2.Id];
        System.assertEquals(1050,acc2.NumberOfEmployees);
        
    
    // before calling the method / create a dummy record for testing
      Course__c course1 = new Course__c();
        course1.Name = 'Java';
        course1.New_Fee__c = 25000;
        course1.Old_Fee__c = 24000;
        course1.Availablility__c ='Online';
        insert course1;
        //now call the method check this record is updated or not
        UpdateOperation.updatingcourserecords();
     Course__c course = [select id,Name,New_Fee__c from Course__c where id = :course1.id];
        System.assertEquals(27000,course.New_Fee__c);
        
        //before calling the method /create a dummy record for testing
         Campaign campaign1 = new Campaign();
         campaign1.Name = 'Big C Mobiles';
         campaign1.ActualCost = null;
         campaign1.Status = 'In Progress';
          insert campaign1;
        //now call the method / check this dummy record is updated or not
        UpdateOperation.updatingcampaignrecords();
      Campaign cam1 =  [select id,Name,ActualCost from Campaign where id = :campaign1.id];
        System.assertEquals(40000,cam1.ActualCost);
        
        //now check else logic /create a dummy record
        Campaign campaign2 = new Campaign();
         campaign2.Name = 'Lot C Mobiles';
         campaign2.ActualCost = 50000;
         campaign2.Status = 'In Progress';
          insert campaign2;
        // now call the method /check this dummy record is updated or not
        UpdateOperation.updatingcampaignrecords();
      Campaign cam2  = [Select id,Name,ActualCost from Campaign where id = :campaign2.id];
        System.assertEquals(65000,cam2.ActualCost);
        
        //first create Dummy record 
        Book__c book8 = new Book__c();
        book8.Name = 'Rambha';
        book8.Author_Name__c= 'Silpa';
        book8.Price__c = 700;
        insert book8;
        
        //now call the method / check this dummy  book is  deleted or not
        UpdateOperation.deletingrecords();
     Integer deleteCount = [select count() from Book__c];
        System.assertEquals(0,deleteCount);
    
}
}
