public class UpdateOperation {
    
    public static void updatingrecords(){
        // i want to update book records --> price of the book
        // write SOQL Query in Query editor
        // syntax for SOQL Query
        // Select id , field1 , field2 from object 
        // make this SOQL Query as Static SOQL Query give square basis []
        // // SOQl Query always results in List Collection
         list<Book__c> books =[select id,Name,Price__c from Book__c];
         //records are there in the books object --> each record can be access from books
         //how to access each record by using for each loop 
             for(Book__c book:books){ 
                 book.price__c+=1000;
             }
        //pronunciate loop for better understanding purpose 
        //for each book taken from books ..that book price is increased by 1000
        if(!books.isEmpty()){
            update books;
        }
             
              
        
        
    }
    public static void deletingrecords(){
        
        // i want to delete books records 
        // bring the records that need to get deleted from model to controller 
        // fetch record ids from delete operation
        // SOQL Query always results in  list collection
       list<Book__c> books= [Select id from Book__c];
        delete books;
    }
    
   
        
   
    public static void updatingAccountsrecords(){
        //now i want to update the account records 
        //then bring the records from model to controller 
        //for that write the SOQL Query
        //syntax for SOQL Query 
        //select id,field1,field2 from Accounts
        //make this SOQL Query as static SOQL Query give square basis[]
        //SOQL Query always results in list collection
        list<Account> accounts = [select id,Name,AnnualRevenue,NumberOfEmployees from Account];
        //records are there in account object --> each record can be access from accounts
        //for accessing or updating each record we can consider each loop 
        for(Account account:accounts){
            if(account.NumberOfEmployees == null){
                account.NumberOfEmployees=550;
            }
            else{
                account.NumberOfEmployees+= 550;
        }
        
        }
        // if statement
        if(!accounts.isEmpty()){
            update accounts;
        }   
    
} 
    
    public static void updatingcourserecords(){
        
        // now i want to upate course records 
        // for this bring the records from model to controller 
        // for that write SOQL Query -->  syntax -->select id,course Name . New fees from object
        // to make this SOQL Query as Static SQOL Query give square basis
        // SQOL Query always returns a list collection or SQOL Query always results in a list collection
           list<Course__c> courses =[select id,Name,New_Fee__c,	Availablility__c from Course__c];
        // now all course records loaded in list collection
        // here courses contains multiple records from object Course__c 
        // for updating multiple records we should access or update each record
        // for this we can use for each loop
        for(Course__c course:courses){    // here courses contains multiple records / course is a single record
            course.New_Fee__c += 2000;    //course.new_fee__c accessing the field of course record
        } 
        // pronunciate for each loop for better understanding purpose 
        // for each course taken from all courses .. that course new fee field is increased by 2000
        // if statement 
        if(!courses.isEmpty()){
            update courses;
        }
    }  
    
    public static void updatingcampaignrecords(){
        // now i want to update campaign records 
       // bring contact records from model to controller 
       // for this write SOQL Query --> syntax --> select id, field1 ,field2 from object
       // make this SOQL Query as static SQOL Query give sqaure blasis
       // SQOL Query always return a list collection or SQOL Query always results in a list collection
         list<Campaign> campaigns = [select id,Name,ActualCost,Status from Campaign]; 
        // now all records in campaign object stored in list collection
        // here campaigns contains multiple records from object Campaign
        // for updating multiple records we should access each single record
        // for accessing each record we have for each loop 
        for(Campaign campaign : campaigns){  // here campaigns contains multiple record / campaign is a single record
            if(campaign.ActualCost == null){
                campaign.ActualCost = 40000;
            }  
            else{
                campaign.ActualCost+= 15000;
            }                                      //campaign.Actualcost --> accessing field of campaign record
        }
        // how to read total loop for understanding purpose
        // for each campaign taken from campaigns ... that campaigns actual cost field is increased by 15000
        // write dml operation outside of loop 
        if(!campaigns.isEmpty()){
            update campaigns;
        }
    }
    
}
