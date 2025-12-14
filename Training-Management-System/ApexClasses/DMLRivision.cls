public class DMLRivision {
   public static void insertrevision(){
    
    //insert multiple records for case object 
    //case is a child object
    //parent objects are contact,account
    //insert parent records first .. aim is to generate parent record id
          //for creating 1 record we need 1 object
          Account account1 = new Account();
          account1.Name ='BIG C Mobiles';
          account1.AnnualRevenue =20000000;
          account1.Industry ='Entertainment';
          account1.Website ='www.bigc.com';
          account1.Rating ='Hot';
          account1.NumberOfEmployees =2000;
          account1.Fax = '256';
          account1.Phone = '26578';          
    
       Insert account1;
       if(account1.id != null){
            
           Contact contact1 = new Contact();
            contact1.Salutation = 'Mr';
            contact1.FirstName = 'Siraj';
            contact1.LastName = 'Rahman';
            contact1.AccountId =account1.id;
            contact1.Department = 'General';
            contact1.Email = 'siraj@gmail.com';
            contact1.Phone = '2456';
            contact1.Title = 'Manager';
           
           Insert contact1;
           if(contact1.id !=null){
                
               Case case1 = new Case();
               case1.Reason = 'Installation';
               case1.Priority = 'High';
               case1.AccountId = account1.id;
               case1.ContactId = contact1.id;
               case1.Origin = 'Web';
               case1.Status = 'New';
               case1.Type = 'Electrical';
               insert case1;
               
           }
           
       }
             
  }
    
    public static void updaterivision(){
//If an Account’s Annual Revenue > 10,00,000, update its Rating = ‘Hot’.
   //  Else if Annual Revenue < 50,000, update its Rating = ‘Cold’.
list<Account> accounts =[select id,Name,AnnualRevenue,Rating from Account
                                  where AnnualRevenue >=1000000];
    if(!accounts.isEmpty()){
        
        for(Account account : accounts){
            
          account.Rating = 'Hot';      
        } 
        update accounts;
        
        
    }
           
       list<Account> accounts1 = [select id,Name,AnnualRevenue,Rating from Account where AnnualRevenue <= 50000];
        if(!accounts1.isEmpty()){
            for(Account account:accounts1){
                
                account.Rating = 'Cold';
            }
            update accounts1;
            
        }
        //Requirement:
     //If an Account has more than 500 employees, update its Industry = 'Enterprise'.
     //If an Account has less than 10 employees, update its Industry = 'Startup
list<Account> accounts2 =[select id,Name,NumberOfEmployees,Industry from Account where NumberofEmployees !=null];
                
        if(!accounts2.isEmpty()){
            
            for(Account account :accounts2){
                if(account.NumberOfEmployees >= 500){
                    account.Industry = 'Enterprise';
                }
                else if(account.NumberOfEmployees <= 10){
                    account.Industry = 'Startup';
                }
                
                }
               update accounts2;
            
        }
        //Requirement:
  //If a Case has Priority = ‘High’ and Status = ‘New’, update Status = ‘In Progress’.
  //If a Case has Priority = ‘Low’ and Status = ‘New’, update Status = ‘On Hold’.
      list<Case> cases = [select id,Priority,Status from Case Where Priority IN('High','Low') and Status ='New'];
        if(!cases.isEmpty()){
            for(Case eachcase: cases){
                if(eachcase.Priority == 'High'){
                    eachcase.status = 'In Progress';      
                }
                else if(eachcase.Priority == 'Low'){
                    eachcase.status = 'On Hold';
                }
            }
            update cases;
        } 
    
        
        
  
        
        
       
        // now delete operation
        
        //If a Case is Closed and was created more than 1 year ago, delete it.
       //If an Account has AnnualRevenue = 0, delete it (maybe a test/unused account).
                Date myDate1;
                myDate1 = Date.today().addYears(-1);
              list<Case> cases5 = [select id,status,createdDate from Case where Status = 'Closed' and createdDate <:myDate1];
        if(!cases5.isEmpty()){
            delete cases5;
        }
          
           list<Account> accounts6 =[select id,AnnualRevenue from Account where AnnualRevenue = 0];
        if(!accounts6.isEmpty()){
            delete accounts6;
        }
        
        //If a Lead is in status = "Closed - Converted" and ConvertedDate is more than 2 years ago, delete it.
      //If a Contact has no email and no phone number (both fields blank), delete it (considered useless data).
             Date twoyearsago;
             twoyearsago = Date.today().addYears(-2);
      list<Lead> leads = [select id,Status from Lead where status ='Closed - Converted' and ConvertedDate < :twoyearsago];
        
        if(!leads.isEmpty()){
            delete leads;
        }       
        
        
      list<Contact> contacts8 = [select id,Email,Phone from Contact where Email = null and Phone = null];
        if(!contacts8.isEmpty()){
            
            delete contacts8;
            System.debug(contacts8);
        }
    }  
    
    public static void booksdelete(){ 
        list<Book__c> books =[select id,name from Book__c where Name Like 'M%' OR Name Like 'B%' OR Name Like 'A%' OR Name Like 'R%'];
                      delete books; 
    }
    
    public static void undeletebooks(){
    list<Book__c> books = [select id,Name from Book__c Where IsDeleted = true ALL Rows];
                   undelete books;
    }
    
}
