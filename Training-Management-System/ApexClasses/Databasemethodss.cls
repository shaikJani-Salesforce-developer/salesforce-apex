public class Databasemethodss{
    public static void deleteoperation(String hope){
        list<Course__c> courses =[select id,Name from Course__c Where Name Like :hope];
            delete courses;
        
} 
    public static void UpsertOperation(){
        
        // upsert --> insert + update
        // for update write SOQL Query
        // for doing both insert and update we need another list
        list<Book__c> upinbooks = new list<Book__C>();
      list<Book__c> books =[select id,Name,Price__c from Book__c where price__c < 2000];
        for(Book__c book:books){
            book.price__c+= 1000;
            upinbooks.add(book);
        }
        //now insert operation
        Book__c book1 = new Book__c();
        book1.Name = 'Rastra koot';
        book1.Author_Name__c = 'Ram';
        book1.Price__c = 500;
        // insert another book
       Book__c book2 = new Book__c();
        book2.Name = 'Akbar Stories';
        book2.Author_Name__c = 'Beerbal';
        book2.Price__c = 600;
        
        
        upinbooks.add(book1);
        upinbooks.add(book2);
        if(!upinbooks.isEmpty()){
            upsert upinbooks;
           
        }
        
        System.debug('No of DML statements used :'+System.limits.getDMLstatements());
        System.debug('No of DML Rows Processed :'+System.limits.getDMLRows());
        
        // upsert opertion on course object
        //upsert --> insert + upate 
        //for updating the records write SOQL 
        list<Course__c> upincourses = new list<Course__c>();
     list<Course__c> courses1 = [select id,Name,New_Fee__c from Course__c where New_Fee__c < 25000];
        for(Course__c course:courses1){
            course.New_Fee__c+= 5000;
            upincourses.add(course);
        }
        // insert new course record
        Course__c course1 = new Course__c();
        course1.name = 'Mantram';
        course1.Availablility__c = 'Online';
        course1.New_Fee__c = 24000;
        course1.Old_Fee__c = 20000;
        // another course
        Course__c course2 = new Course__c();
        course2.Name = 'thantra';
        course2.Availablility__c = 'Online';
        course2.Old_Fee__c = 20000;
        course2.New_Fee__c = 24000;
        upincourses.add(course1);
        upincourses.add(course2);
        if(!upincourses.isEmpty()){
            upsert upincourses;
            System.debug('No of dML Statements used :'+System.limits.getDMLStatements());
        System.debug('No of dML Rows Processed :'+System.limits.getDMLRows());
        }
       
        
    }
    
    public static void databasemethods(){
         //record 1
        Course__c course1 = new Course__c();
        course1.name = 'Biology 2';
        course1.Availablility__c = 'Online';
        course1.New_Fee__c = 26000;
        course1.Old_Fee__c = 21000;
            
            // record 2
        Course__c course2 = new Course__c();
        course2.Name = 'Bottony'; 
        course2.Availablility__c = 'Online';
        course2.Old_Fee__c = 28000;
        course2.New_Fee__c = 27000;
        
        list<Course__c> courses = new list<Course__c>();
        courses.add(course1);
        courses.add(course2);
        
        //insert courses;
        //record 2 has validation error --> bad record
        //record 1 is gud record
        //if even single bad record is there then gud records dont go into org 
        // now do database methods for sending gud records into org
      Database.SaveResult[] results = Database.insert(courses,false);  
        //  Database.insert(courses,false); /this results success file & error file 
        //  this success file and error file save in list --> Database.SaveResult[] results
        //  in results there is success file and error file
        if(!results.isEmpty()){
            //if results is not empty --> then i want to access success file and error file
            for(Database.SaveResult result:results){
                if(result.isSuccess()){
                    //get the id of the success record
                 System.debug('Successfully Inserted Courses :'+result.getid());
                
                }
                
                else{
                    for(Database.Error error : result.getErrors()){
                        System.debug('Get the status code '+error.getStatuscode());
                        System.debug('Get the fileds :'+error.getfields());
                        System.debug('Get error message :'+error.getMessage());
                    }
                }
            }
            
        }
        
        
    }
    public static void practicedatabasemethods(){
        // insert operation 
        // instead of doing dml operation write database method
        //record1
        Course__c course1 = new Course__c();
           course1.name = 'Course 40';
           course1.New_Fee__c = 26000;
           course1.Old_Fee__c = 22000;
           course1.Availablility__c = 'Online';
        
        //record2
        Course__c course2 = new Course__c();
          course2.Name = 'Course 50' ;
          course2.New_Fee__c = 29000;
          course2.Old_Fee__c = 40000;
          course2.Availablility__c = 'Online';
        
        list<Course__c> courses = new list<Course__c>();
          courses.add(course1);
          courses.add(course2);
        
        // instead of making dml statement lets write database method
        
        Database.SaveResult[] results = Database.insert(courses,false); // false --> acts as Database metho
          // results have both success and error files
        if(!results.isEmpty()){
            
            for(Database.SaveResult result:results){
                //if the result is sucess then get iD
                if(result.isSuccess()){
                    System.debug('Successfully Inserted Courses :'+result.getid());
                }
                
                else{
                    for(Database.Error error : result.getErrors()){
                        System.debug('get status code :'+error.getStatuscode());
                       System.debug('Get error field :'+error.getfields());
                        System.debug('Get Error Message :'+error.getMessage());
                       
                    }
                }
            }
        }
        /*Query Accounts where Industry = 'Technology'.
Change their Rating field to "Hot".
Update using Database.update(accounts, false).
Print success Ids and errors.*/  
      list<Account> accounts = [select id,Name,Rating,Industry from Account Where Industry = 'Technology'];
        if(!accounts.isEmpty()){
            
            for(Account account:accounts){
                if(account.Industry == 'Technology'){
                    account.Rating = 'Hot';
                }
                
            }
            // instead of doing dml operation write database method
    Database.SaveResult[] results1 = Database.update(accounts,false); // false --> act as database method
            if(!results1.isEmpty()){
                
                for(Database.SaveResult result : results1){
                    if(result.isSuccess()){
                        // get the iD of Successfull file
                      System.debug('updated Account id :'+result.getId());
                    }
                    else{
                        for(Database.Error error : result.getErrors()){
                            System.debug('Error field :'+error.getfields());
                            System.debug('Error Message :'+error.getMessage());
                        }
                    } 
                    
                } 
            }
               
        }
        /* Query some Accounts with Industry = 'Entertainment'.
Delete them using Database.delete(accounts, false) → partial success.
Print success Ids and error messages. */

List<Account> listAccounts = [SELECT Id, Name, Industry FROM Account WHERE Industry = 'Entertainment'];

if (!listAccounts.isEmpty()) {
    Database.DeleteResult[] results4 = Database.delete(listAccounts, false);

    if (!results4.isEmpty()) {
        for (Database.DeleteResult result : results4) {
            if (result.isSuccess()) {
                System.debug('Deleted Account Id: ' + result.getId());
            } else {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error field: ' + error.getFields());
                    System.debug('Error message: ' + error.getMessage());
                }
            }
        }
    }
}

        // upsert operation 
        // insert + update 
        /*Query existing Accounts with Industry = 'Banking'.
Update a field (Rating) Hot for these existing accounts.
Create 2 new Accounts with Industry = 'Telecommunications.
Combine all into a list.
Upsert using Database.upsert(list, false).
Print success Ids and error messages.0---------------=]\
*/
   list<Account> acRecs = [select id,Name,Industry from Account Where industry ='Banking'];
        list<Account> upsertaccounts = new list<Account>();
        
        for(account account:acRecs){
            if(account.Industry == 'Banking'){
                account.Rating = 'Hot';
                upsertaccounts.add(account);
            }
        }
        // now insert 
        Account account1 = new Account();
        account1.Name = 'Motorola Mobiles';
        account1.Rating = 'Warm';
        account1.AnnualRevenue = 20000000;
        account1.Industry = 'Telecommunications';
        account1.NumberofLocations__c = 7000;
        account1.Website = 'www.moto.com';
        account1.NumberofLocations__c = 50;
        
        //record 2
        Account account2 = new Account();
        account2.Name = 'Rama Textiles';
        account2.Rating = 'Hot';
        account2.AnnualRevenue = 50000000;
        account2.Industry = 'Manufacturing';
        account2.NumberofLocations__c = 5000;
        account2.Website = 'www.ramat.com';
        account2.NumberofLocations__c = 78;
        upsertaccounts.add(account1);
        upsertaccounts.add(account2);
        // instead of doing upsert write database method
          
       Database.UpsertResult[] acResults = Database.upsert(upsertaccounts,false);
        if(!acResults.isEmpty()){
            for(Database.UpsertResult result:acResults){
                if(result.isSuccess()){
                    System.debug('Get successfull account :'+result.getId());
                    
                }
                else{
                    for(Database.Error error:result.getErrors()){
                        
                        System.debug('Get error Fields : '+error.getfields());
                        System.debug('Get Error Message :'+error.getMessage());
                    }
                }
            }
        }
        
        /*undelete */
       list<Account> accountsList= [select id,Name,isDeleted from Account Where isDeleted = true ALL ROWs];
        //instead of doing dml operation write database method
                Database.UndeleteResult[] Reresults = Database.undelete(accountsList,false);
        if(!Reresults.isEmpty()){
            for(Database.UndeleteResult result:Reresults){
                if(result.isSuccess()){
                    System.debug('Restored accounts :'+result.getId());
                }
                else{
                    for(Database.Error error:result.getErrors()){
                        System.debug('Get error field :'+error.getFields());
                        System.debug('Get error Message :'+error.getMessage());
                    }
                }
            }
            
        }
    }
    public static void exceptionmethod(){
       
       Book__c book1 = new Book__c();
            book1.Name = 'King Alexander';
            book1.Author_Name__c = 'John'; 
            book1.Price__c =900;
      
       Book__c book2 = new Book__c();
          book2.Name = 'Maratha History';
          book2.Price__c = 700;
        
       Book__c book4 = new Book__c();
          book4.Name = 'Maurya History';
          book4.Author_Name__c = 'Siva';
        
      list<Book__c> books = new list<Book__c>();
        books.add(book1);
        books.add(book2);
        books.add(book4);
        try{
        if(!books.isEmpty()){
           insert books;
        }        
        }catch(exception e){
            System.debug('Error Message :'+e.getMessage());
            System.debug('Cause of the Error :'+e.getCause());
            System.debug('Error Line Number :'+e.getLineNumber());
            System.debug('Error Type :'+e.getTypeName());
        } 
         
    }
    
    
    public static void checkwithchatgpt(){
        
        List<Book__c> books1 = new List<Book__c>();
books1.add(new Book__c(Name='Book1',Price__c=100,Author_Name__c='A1'));
books1.add(new Book__c(Price__c=200,Author_Name__c='A2')); // missing Name → fail
books1.add(new Book__c(Name='Book3',Author_Name__c='A3')); // missing Price__c → may fail

Database.SaveResult[] sr = Database.insert(books1,false);

for (Integer i=0; i<sr.size(); i++){
    if(sr[i].isSuccess()){
        System.debug('Inserted: '+books1[i].Name);
    } else {
        System.debug('Failed: '+(books1[i].Name != null ? books1[i].Name : '<NULL Name>'));
        // Loop through all errors for this record
        for(Database.Error err : sr[i].getErrors()){
            System.debug('   Error Message: '+err.getMessage());
            System.debug('   Field(s): '+err.getFields());
            System.debug('   Status Code: '+err.getStatusCode());
        }
    }
}
        
           //record 1
           Book__c book1 = new Book__c();
          book1.name = 'Bookk1';
          book1.Price__c=800;
          book1.Author_Name__c = 'John';
         
        Book__c book2 = new Book__c();
         book2.Name = 'book2';
          book2.Price__c = 900;
         book2.Author_Name__c = 'raja';
        
        Book__c book4 = new Book__c();
         book4.Name = 'Book4';
         book4.Price__c = 500;
         book4.Author_Name__c='raheem';
        
        Book__c book5 = new Book__c();
        book5.Name = 'book5';
        book5.Price__c = 700;
        
        Book__c book6 = new Book__c();
        book6.Name = 'Book6';
        book6.Price__c = 700;
        
        Book__c book7 = new Book__c();
         book7.Name = 'Book7';
         book7.Author_Name__c = 'sir';
        
        
        Book__c book8 = new Book__c();
         book8.Name = 'Book8';
         book8.Author_Name__c = 'Roj';
        
        Book__c book9 = new Book__c();
        book9.Name = 'Book9';
        book9.Author_Name__c = 'Reeja';
        book9.Price__c = 900;
        
        Book__c book10 = new Book__c();
        book10.Name = 'Book10';
        book10.Author_Name__c='boss';
        book10.Price__c = 900;
        
        Book__c book11 = new Book__c();
         book11.Name='Book11';
         book11.Author_Name__c='ramesh';
        
        list<Book__c> books = new list<Book__c>();
        books.add(book1);
        books.add(book2);
        books.add(book4);
        books.add(book5);
        books.add(book6);
        books.add(book7);
        books.add(book8);
        books.add(book9);
        books.add(book10);
        books.add(book11);
        
        
            //result
           if(!books.isEmpty()){
               try{ 
           // instead of doing dml operation write database methods
         Database.SaveResult[] inresults = Database.insert(books,false);
          
           
            
            if(!inresults.isEmpty()){
                for(Database.SaveResult result :inresults){
                    if(result.isSuccess()){
                        System.debug('successfully inserted records :'+result.getId());
                    
                    }
                    
                    else{
                        
                        for(Database.Error error:result.getErrors()){
                            System.debug('Error fields :'+error.getfields());
                            System.debug('Error Message :'+error.getMessage());
                           
                        } 
                    }
                    
                } 
            }
            
            
            
        }catch(exception e){
            
            System.debug('Error Message :'+e.getMessage());
            System.debug('cause of the error :'+e.getCause());
            System.debug('Error line number :'+e.getLineNumber());
            System.debug('Error type :'+e.getTypeName());
        }
        
        
            
        }
        
    }
    public static void exceptionupdate(){
     list<Book__c> books = [select id,Name,Price__c from Book__c where Price__c < 1000];
        if(!books.isEmpty()){
            
            for(Book__c book:books){
                book.Price__c+= 2000;
            }
            
            try{
                Database.SaveResult[] results = Database.update(books,false);
            
            for(Database.SaveResult result : results){
                if(result.isSuccess()){
                    System.debug('Successfully Updated :'+result.getId());
                    
                }
                else{
                    for(Database.Error error : result.getErrors()){
                        System.debug('Error Fields :'+error.getfields());
                        System.debug('Error Message :'+error.getMessage());
                    }
                }
                
            }
                
            }catch(exception e){
                System.debug('Error Message :'+e.getMessage());
                System.debug('Cause of the error :'+e.getCause());
                System.debug('Error Line Number :'+e.getLineNumber());
                System.debug('Error Type :'+e.getTypeName());
                
            }
            
        }
                
            
       
        
    }
    public static void trycatchdelete(){
        
     list<Book__c> books  =  [select id,Name from Book__c where name Like 'B%' Or Name like '%W%'];
        
        if(!books.isEmpty()){
            try{
                
                Database.deleteResult[] results = Database.delete(books,false);
            
            if(!results.isEmpty()){
                for( Database.deleteResult result:results){
                    if(result.isSuccess()){
                    System.debug('deleted records :'+result.getId());
                }
                    else{
                        for(Database.Error error : result.getErrors()){
                            System.debug('Error Message :'+error.getMessage());
                            System.debug('Error fields :'+error.getFields());
                        }
                    }
                
            }
        }

                
            }catch(exception e){
                
                System.debug('Get Error :'+e.getMessage());
                System.debug('Error line number :'+e.getLineNumber());
            }
            
                   
        } 
          
    } 
        
        
        
     
}
