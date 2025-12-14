@isTest
public class DatabasemethodssTest {
    @isTest static void testdelete(){
    // before calling the method create a dummy record
     Course__c course1 = new Course__c();
      course1.Name ='Java';
      course1.New_Fee__c = 25000;
      course1.Old_Fee__c = 22000;
      course1.Availablility__c ='Online';
        course1.Approval_Status__c = 'Rejected';
        insert course1;
    // call the method & check this dummy record deleted or not
      Databasemethodss.deleteoperation('J%');
    Integer couCount  =  [select Count() from Course__c];
        System.assertEquals(0,couCount);
        
} 
    @istest static void testUpsert(){
        //first test update operation
        //before calling the method create a dummy record
        Book__c book1 = new Book__c();
        book1.name ='Raja Raja Chola';
        book1.Author_Name__c ='lenin';
        book1.Price__c = 700;
        insert book1;
        //call the method & check this dummy record updated or not
        Databasemethodss.UpsertOperation();
    Book__c bookup  =  [select id,Name,Price__c from Book__c where Id =:book1.Id];
        System.assertEquals(1700,bookup.Price__c);
        //now coming to insert operation
       Integer booksCount = [Select count() from Book__c];
        System.assertEquals(3,booksCount);
        //now check book records inserted or not
      list<Book__c> books = [select id,Name from Book__c where Name IN('Rastra koot','Akbar Stories')ORDER BY Name];
        System.assertEquals('Akbar Stories',books[0].Name);
        System.assertEquals('Rastra koot',books[1].name);
        
        //testing upsert operation
        //first test update operation
        //test the insert operation
        Course__c course = new Course__c();
        course.name = 'Salesforce';
        course.New_Fee__c = 24000;
        course.Old_Fee__c = 22000;
        course.Availablility__c = 'Online';
        insert course;
        Databasemethodss.UpsertOperation();
  Course__c courseUpdate  =  [select id,name,new_fee__c from Course__c where id =:course.id];
        System.assertEquals(29000,courseUpdate.New_Fee__c);
        integer courseCount = [select count() from Course__c];
        System.assertEquals(5,courseCount);
     list<Course__c> courseIn =  [select id,name from Course__c where name IN('Mantram','thantra')];
        System.assertEquals('Mantram',courseIn[0].name);
        System.assertEquals('thantra',courseIn[1].name);
        
    }
   @istest static void testDataBaseMethods(){
        Databasemethodss.databasemethods();
       Integer gudCourseCount = [select count() from Course__c where name ='Biology 2'];
       System.assertEquals(1,gudCourseCount);
       
       Integer badCourseCount = [select count() from Course__c where name = 'Bottony'];
       System.assertEquals(0,badCourseCount);
       
       list<Course__c> course = [select id,name,New_fee__c from Course__c where name = 'Biology 2'];
        System.assertEquals('Biology 2',course[0].name);
       System.assertEquals(26000,course[0].New_Fee__c);
    }
   @istest static void testPracticeDatabase(){
        Databasemethodss.practicedatabasemethods();
       //check gud record count
       Integer gudCourseCount = [select count() from Course__c where name ='Course 40'];
       System.assertEquals(1,gudCourseCount);
       //check bad count its zero because bad records wont go in org..
       Integer badCourseCount = [select count() from Course__c where name = 'Course 50'];
       System.assertEquals(0,badCourseCount);
       
       list<Course__c> course = [select id,name,new_fee__c from Course__c where name = 'Course 40'];
       System.assertEquals('Course 40',course[0].name);
       System.assertEquals(26000,course[0].New_Fee__c);
   } 
       @istest static void testAc(){
        Account account = new Account();
         account.name = 'PRK Solutions';
         account.Industry = 'Technology';
         account.Phone = '67890';
         account.rating = 'Warm';
         account.Fax = '345';
        insert account;
     Databasemethodss.practicedatabasemethods();
     Account ac = [select id,name,industry,rating from Account where id=:account.id];
     System.assertEquals('Hot',ac.Rating);
     
    }
    

    @isTest
    static void testDeleteAc() {
     
       

        // Create test Account with Industry = 'Entertainment'
        Account acc = new Account();
        acc.Name = 'PR Solutions';
        acc.Industry = 'Entertainment';
        acc.Phone = '67891';
        acc.Rating = 'Hot';
        acc.Fax = '349';
        acc.Active__c = 'No';
        insert acc;

        // Run the actual method
        Test.startTest();
        Databasemethodss.practicedatabasemethods();
        Test.stopTest();

        // Verify record is deleted
        Account ac = [select id,name,isDeleted from Account where id=:acc.id ALL ROWS];
        System.assertEquals(true,ac.IsDeleted);
    }
    @istest static void testupsertAc(){
        Account acc = new Account();
        acc.Name = 'HR Infra Solutions';
        acc.Industry = 'Banking';
        acc.Phone = '67897';
        acc.Rating = 'Warm';
        acc.Fax = '349';
        acc.Active__c = 'No';
        insert acc;
        Databasemethodss.practicedatabasemethods();
        Account account = [select id,name,industry,rating from Account where id = :acc.id];
        System.assertEquals('Hot',account.Rating);
        
        integer acCount1 = [select count() from Account where name IN('Motorola Mobiles','Rama Textiles')];
        System.assertEquals(2,acCount1);
        
    }
  @isTest
static void testUndeleteAc() {
    // Create account
    Account acc = new Account(
        Name = 'Mahendra Solutions',
        Industry = 'Banking',
        Phone = '67896',
        Rating = 'Warm',
        Fax = '346',
        Active__c = 'No'
    );
    insert acc;

    // Delete the record
    Test.startTest();
    delete acc;
    Test.stopTest();

    // ✅ Query your *specific* deleted record
    Account deletedAcc = [
        SELECT Id, Name, IsDeleted
        FROM Account
        WHERE Id = :acc.Id
        
        LIMIT 1 ALL Rows
    ];
    System.assertEquals(true, deletedAcc.IsDeleted, 'Record should be deleted');

    // Run undelete logic
    Test.startTest();
    Databasemethodss.practicedatabasemethods();
    Test.stopTest();

    // ✅ Query again to verify undelete
    Account restoredAc = [
        SELECT Id, Name, IsDeleted
        FROM Account
        WHERE Id = :acc.Id
        
        LIMIT 1 ALL Rows
    ];
    System.assertEquals(false, restoredAc.IsDeleted, 'Record should be undeleted');
}
    
    
    @istest static void testTryCatch(){
        
        Databasemethodss.exceptionmethod();
        integer gudBooksCount = [select count() from Book__c];
        System.assertEquals(1,gudBooksCount);
   Book__c book = [Select id,name from Book__c where Name = 'King Alexander'];
        System.assertEquals('King Alexander',book.name);
        
        Integer badBooksCount = [select count() from Book__c];
        System.assertEquals(0,badBooksCount);
    }
    
   @istest static void testException(){
        Databasemethodss.checkwithchatgpt();
        integer gudBooksCount = [select count() from Book__c];
        System.assertEquals(6,gudBooksCount);
       Book__c book = [Select id,name from Book__c where Name = 'Book1'];
        System.assertEquals('Book1',book.name);
       Book__c book2 = [Select id,name from Book__c where Name = 'book2'];
        System.assertEquals('book2',book.name);
       
       Book__c book4 = [Select id,name from Book__c where Name = 'Book4'];
        System.assertEquals('Book4',book.name);
       
       Book__c book9 = [Select id,name from Book__c where Name = 'Book9'];
        System.assertEquals('Book9',book.name);
       Book__c book10 = [Select id,name from Book__c where Name = 'Book10'];
        System.assertEquals('Book10',book.name);
       
       Integer badBooksCount = [select count() from Book__c];
        System.assertEquals(0,badBooksCount);
       
    }
    
   @istest static void testExceptionUpdate(){
        Book__c book = new Book__c();
        book.Name = 'Rayudu';
       book.Author_Name__c = 'Ambati';
       book.Price__c = 700;
       insert book;
       Databasemethodss.exceptionupdate();
     Book__c upBook = [Select id,name,price__c from Book__c where id =:book.id];
       System.assertEquals(2700,upBook.Price__c);
    }
    
    @istest static void testExceptionDelete(){
        Book__c book = new Book__c();
        book.Name = 'Boom';
       book.Author_Name__c = 'Ambati';
       book.Price__c = 700;
       insert book;
     
        
        Book__c book1 = new Book__c();
        book1.Name = 'Ab Warudu';
       book1.Author_Name__c = 'Ambati';
       book1.Price__c = 700;
       insert book1;
       
        Databasemethodss.trycatchdelete();
  Book__c bookUp   =  [select id,name,isDeleted from Book__c where id =:book.id ALL Rows];
        System.assertEquals(true,bookup.IsDeleted);
        
        Book__c bookUp2  =  [select id,name,isDeleted from Book__c where id =:book1.id ALL Rows];
        System.assertEquals(true,bookUp2.IsDeleted);
        
        
    }
}
