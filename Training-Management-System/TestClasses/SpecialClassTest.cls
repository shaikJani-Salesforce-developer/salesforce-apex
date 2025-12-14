@isTest
public class SpecialClassTest {

     @istest static void testupopportunities(){
        
        // before calling method create 2 dummy records
         Opportunity opportunity1 = new Opportunity();
        opportunity1.Name ='BiGB Bussiness deal';
        opportunity1.StageName = 'Prospecting';
        opportunity1.Amount = 80000;
        opportunity1.CloseDate = Date.today().addDays(20);
        insert opportunity1;
         
         
         Opportunity opportunity2 = new Opportunity();
        opportunity2.Name ='Lahore Bussiness deal';
        opportunity2.StageName = 'Negotiation/Review';
        opportunity2.Amount = 80000;
        opportunity2.CloseDate = Date.today().addDays(-1);
        insert opportunity2;
         
        //now call the methoD check this Dummy record updated or not
         SpecialClass.upopportunities();
      Opportunity opp1 = [select id,Name,StageName,Amount from Opportunity where id = :opportunity1.id];
        System.debug('StageName after update for opp: ' + opp1.StageName);
        System.assertEquals('Qualification',opp1.StageName);
        
     
        Opportunity opp2 = [select id,Name,StageName,Amount,CloseDate from Opportunity where id = :opportunity2.id];
        System.debug('StageName after update for opp2: ' + opp2.StageName);
        System.assertEquals('Closed Lost',opp2.StageName);
    } 
    
@istest static void testcontact(){
       //before 2 dummy records before calling the method
        Contact contact1 = new Contact();
       contact1.FirstName = 'Mahesh';
       contact1.LastName ='Babu';
       contact1.Email = 'mahesh@gmail.com';
       contact1.LeadSource = 'Phone';
       contact1.Phone = '25678';
       insert contact1;
       
       Contact contact2 = new Contact();
       contact2.FirstName = 'Ramesh';
       contact2.LastName ='Babu';
       contact2.Email = 'Ramesh@yahoo.com';
       contact2.LeadSource = 'Phone';
       contact2.Phone = '25678';
       insert contact2;
       
       //now call the method check this dummy records updated or not
       SpecialClass.upcontact();
       Contact con1 = [select id,Name,Email,LeadSource from Contact where id =:contact1.Id];
       System.assertEquals('Web',con1.LeadSource);
       Contact con2 = [select id,Name,Email,LeadSource from Contact where id =:contact2.Id];
       System.assertEquals('Partner Referral',con2.LeadSource); 
}
    @isTest static void testcase(){
       //before calling the method insert 2 dummy records 
       Case case1 = new Case();
       case1.Priority ='High';
       case1.Status = 'New';
       case1.Origin ='Web';
       case1.Reason ='Breakdown';
       insert case1;
    
    Case case2 = new Case();
       case2.Priority ='Low';
       case2.Status = 'New';
       case2.Origin ='Phone';
       case2.Reason ='Breakdown';
       insert case2;
    
    //now call the method check this dummy records updated or not
    
        SpecialClass.upcontact();
   Case caseup = [select id,Priority,Status,Origin,Reason from Case where Id = :case1.Id];
    System.assertEquals('Escalated',caseup.Status);
    Case upcase = [select id,Priority,Status,Origin,Reason from Case where Id = :case2.Id];
    System.assertEquals('Closed',upcase.Status);
    
    } 
    @istest static void testaccount(){
        //before calling method create 2 dummy records
        Account account1 = new Account();
         account1.Name = 'Aha';
         account1.AnnualRevenue =1100000;
        account1.Industry ='Technology';
        account1.NumberOfEmployees = 500;
        account1.Rating = 'Warm';
        insert account1;
        
        Account account2 = new Account();
         account2.Name = 'Amazon Prime';
         account2.AnnualRevenue = 400000;
        account2.Industry ='Finance';
        account2.NumberOfEmployees = 500;
        account1.Rating ='Warm';
        insert account2;
        
        //now call the method check this dummy records get updated or not
        SpecialClass.upaccount();
       Account ac1 = [select id,Name,Industry,AnnualRevenue,Rating from Account where id= :account1.Id];
        System.assertEquals('Hot',ac1.Rating);
        Account ac2 = [select id,Name,Industry,AnnualRevenue,Rating from Account where id= :account2.Id];
        System.assertEquals('Cold',ac2.Rating);
    }
}
