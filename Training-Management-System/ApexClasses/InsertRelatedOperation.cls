public class InsertRelatedOperation {
   public static void insertingrelatedrecords(){
        
        //account ,contact , opportunity ,Case objects are in relationship
        //contact is a child object --> account is a parent object
        //Opportunity is a child object --> account is a parent object
        //case is a child object -->  contact , accounts are parent objects for Case object
        //now the task is inserting related records 
        //for inserting a child record --> we should already have a parent record
        //Step 1 --> insert a parent record
        //step 2 --> with the help of id insert child record
        //syntax for arranging a memory space --> className.obj = new className();
        //for loading the values  --> syntax --> obj.filedname = value;
           Account account1 = new Account();
           account1.Name = 'TV5 Media House';
           account1.Industry = 'Media';
           account1.AnnualRevenue = 2000000;
           account1.NumberOfEmployees = 1000;
           account1.Phone ='24567';
           account1.Rating ='Warm';
           account1.Type = 'Customer - Direct';
           account1.Website = 'www.tv5network.com';
        // now perform insert operation
        // syntax --> insert obj;
           insert account1;
       // if statement 
       if(account1.id !=null){
           System.debug('Account record :'+account1);
       
        // now inserting child record
        // creating a memory space for child record
        // syntax --> className obj = new className();
        // for loading the values --> obj.fieldName = Value;
        Contact contact1 = new Contact();
         contact1.Salutation ='Mr';
         contact1.FirstName = 'Murthy';
         contact1.LastName ='kumar';
         contact1.AccountId = account1.id;
         contact1.Title = 'Chief Editor';
         contact1.Department ='General';
         contact1.MobilePhone= '8008840960';
         contact1.Email = 'murthytv5@gmail.com';
         // insert child record
         // syntax --> insert obj;
           insert contact1;
       //if statement
       if(contact1.id !=null){
           System.debug('Contact record :'+contact1);
           
           
           // in contact id if block we should insert Case record
           // for inserting case record we should have memory space 
           // syntax --> className obj = new className();
           // loading the values --> obj.fieldName = value 
           
             Case case1 = new Case();
             case1.AccountId = account1.id;
             case1.ContactId = contact1.id;
             case1.Type = 'Electronic';
             case1.Reason = 'Breakdown';
             case1.Status = 'Closed';
             case1.Priority = 'High';
             case1.Origin ='Phone';
             case1.Product__c = 'GC1040';
             
           // perform insert Operation
           // syntax --> insert case1;
             insert case1;
           // now if statement 
           if(case1.id !=null){
               System.debug('Case record :'+case1);
           }
           
           
           
       }
           
         // note --> opportunity is child object --> account is parent object 
         // in Account parent if block i want to insert Opportunity record
         // creating memory space for Opportunity record --> className obj = new className();
         // loading the values  --> obj.fieldname = value;
         Opportunity Opportunity1 = new Opportunity();
           Opportunity1.Name = 'TV5 Business Deal';
           Opportunity1.AccountId = account1.id;
           Opportunity1.Type = 'New Customer';
           Opportunity1.LeadSource = 'Web';
           Opportunity1.Amount = 10000000;
           Opportunity1.CloseDate = Date.newInstance(2025, 12, 19);
           Opportunity1.StageName = 'Needs Analysis';
           Opportunity1.Probability = 20;
           // now perform insert operation
           // syntax --> insert obj;
           insert Opportunity1;
           // if statement
           if(Opportunity1.id !=null){
               System.debug('Opportunity record :'+Opportunity1);
           }
       
           
       } 
        
       
    }
       
}
