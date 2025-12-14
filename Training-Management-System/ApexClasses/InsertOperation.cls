public class InsertOperation {
   public void insertstandardrecord(){
       
       //creating the records in the account object 
       //step 1 --> create a memory space 
       //Syntax for creating object --> className obj = new className();
       //step 2 --> load the values
       //syntax for calling methods --> obj.memMethod(inputs);
       //here obj.FieldName = value;
       // step 3 --> perform the operations (insert ,update.. )
       // step 4 --> if conditional statement
       
       Account account1 = new Account();
       account1.Name = 'Genetic info solutionss';
       account1.Rating = 'Hot';
       account1.AnnualRevenue = 2000000;
       account1.Phone = '24567';
       account1.Fax = '256';
       account1.Industry = 'Technology';
       account1.Website = 'www.genetic.com';
       account1.NumberOfEmployees = 500;
       // Now perform insert operation
       // syntax --> insert obj;
         
    
       
       // now creating new object for inserting 2nd record
       // syntax --> className obj = new className();
         Account account2 = new Account();
       account2.Name = 'Capgemini';
       account2.Rating = 'Hot';
       account2.Type = 'Installation Partner';
       account2.AnnualRevenue = 2000000000;
      account2.Phone = '67894';
      account2.Industry = 'Technology';
       account2.NumberOfEmployees = 10000;
       account2.Website ='www.capgemini.com';
       account2.BillingCountry = 'India';
       // Now perform insert operation
       // syntax --> insert obj;
         
       
       
        // creating new object for inserting the 3rd record
        Account account3 = new Account();
        account3.Name = 'Rise College of Engineering & Technology';
        account3.Rating = 'Warm';
       account3.Industry = 'Education';
       account3.AccountNumber = '124567890';
       account3.Phone = '65789';
       account3.Type = 'Customer - Direct';
       account3.AnnualRevenue = 400000000;
       account3.Website = 'www.ssnedservice.com';
       account3.BillingCity = 'Ongole';
       // now perform the insert operation
       // syntax --> insert obj;
         
       
       
       // now creating 4th record
       // syntax for Object --> className obj = new className();
        Account account4 = new Account();
         account4.Name = 'DMart Store';
         account4.AccountNumber = '02567894547';
         account4.AnnualRevenue = 5000000;
        account4.Industry = 'Food & Beverage';
        account4.Phone = '56789';
       account4.Rating ='Hot';
       account4.ShippingCity = 'Guntur';
       account4.Type = 'Installation Partner';
       account4.Website ='www.dmartservices.com';
       // now Perform insert Operation
       // syntax --> insert obj;
       
       
       // now creating 5th record for account object
       Account account5 = new Account();
        account5.Name = 'Aparna Cyber Cafe';
        account5.AnnualRevenue = 5000000;
       account5.NumberOfEmployees = 1000;
       account5.Website = 'www.aparnacybersolution.com';
       account5.Fax = '456';
       account5.Industry = 'Technology';
       account5.Rating = 'Hot';
       //now perform the insert operation
       //syntax --> insert obj;
          
       list<Account> accounts = new list<Account>();
        accounts.add(account1);
        accounts.add(account2);
        accounts.add(account3);
        accounts.add(account4);
        accounts.add(account5);
       if(!accounts.isEmpty()){
           insert accounts;
       }
         
   
       
   }   
       
           

   
    public static void insertcustomrecord(){
        
        //creating the records in the Projects object (custom Object)
       //step 1 --> create a memory space 
       //Syntax for creating object --> className obj = new className();
       //step 2 --> load the values
       //syntax for calling methods --> obj.memMethod(inputs);
       //in this case obj.FieldName = value;
       // step 3 --> perform the operations (insert ,update.. )
       // step 4 --> if conditional statement
       
       //creating 1st record in Projects Object
        Projects__c  project1 = new Projects__c();
        project1.Name = 'Project OG';
        project1.Budget__c = 500000;
        project1.start_date__c = Date.newInstance(2025, 09, 01);
        project1.end_date__c = Date.newInstance(2025, 11, 20);
        project1.Priority__c = 'High';
        project1.actual_cost__c = 400000;
        project1.Status__c = 'On Hold';
        // now perform the insert Operation
        // syntax --> insert project1;
        
        
        //creating 2nd record in Projects Object
        Projects__c  project2 = new Projects__c();
        project2.Name = 'Project Lenin';
        project2.Budget__c = 50000;
        project2.start_date__c = Date.newInstance(2025, 08, 09);
        project2.end_date__c = Date.newInstance(2025, 10, 24);
        project2.Priority__c = 'High';
        project2.actual_cost__c = 40000;
        project2.Status__c = 'In Progress';
        // now perform the insert Operation
        // syntax --> insert project1;
        
        
        
        //creating 3rd record in Projects Object
        Projects__c  project3 = new Projects__c();
        project3.Name = 'Project Singam';
        project3.Budget__c = 100000;
        project3.start_date__c = Date.newInstance(2025, 07, 01);
        project3.end_date__c = Date.newInstance(2025, 12, 21);
        project3.Priority__c = 'High';
        project3.actual_cost__c = 90000;
        project3.Status__c = 'In Progress';
        // now perform the insert Operation
        // syntax --> insert project1;
        
        
         //creating 4th record in Projects Object
        Projects__c  project4 = new Projects__c();
        project4.Name = 'Project dhruva';
        project4.Budget__c = 100000;
        project4.start_date__c = Date.newInstance(2025, 07, 01);
        project4.end_date__c = Date.newInstance(2025, 12, 21);
        project4.Priority__c = 'High';
        project4.actual_cost__c = 90000;
        project4.Status__c = 'On Hold';
        // now perform the insert Operation
        // syntax --> insert project1;
        
         //creating 5th record in Projects Object
        Projects__c  project5 = new Projects__c();
        project5.Name = 'Project Chola';
        project5.Budget__c = 100000;
        project5.start_date__c = Date.newInstance(2025, 08, 04);
        project5.end_date__c = Date.newInstance(2025, 11, 24);
        project5.Priority__c = 'High';
        project5.actual_cost__c = 90000;
        project5.Status__c = 'On Hold';
        // now perform the insert Operation
        // syntax --> insert project1;
        
        list<Projects__c> projects = new list<Projects__c>();
        projects.add(project1);
        projects.add(project2);
        projects.add(project3);
        projects.add(project4);
        projects.add(project5);
        
        if(!projects.isEmpty()){
            
            insert projects;
        }
        

        
        
    }
    
    
}
