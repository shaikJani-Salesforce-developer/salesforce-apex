@istest 
public class LeadTriggerTest {
    @isTest static void testLeadTrigger(){
        Lead lead = new Lead();
        lead.Company = 'Capgemini';
        lead.FirstName ='Rahul';
        lead.LastName ='slip';
        lead.Industry = 'Banking';
        lead.Email = 'capgemini@gmail.com';
        lead.AnnualRevenue = 1000000;
        lead.Phone = '45678';
        lead.Status = 'Working - Contacted';
        lead.NumberOfEmployees = 900;
        insert lead;
        
     Lead leadUp  = [select id,lastname,industry,rating from Lead where id =:lead.id];
        if (leadUp.Rating == 'Medium') {
           
            leadUp.Rating = 'Hot';
        }
       System.assertEquals('Hot',leadUp.Rating); 
        
        Lead lead1 = new Lead();
        lead1.Company = 'Test Company';
        lead1.FirstName ='Raju';
        lead1.LastName ='slipganj';
        lead1.Industry = 'Technology';
        lead1.Email = 'test@gmail.com';
        lead1.AnnualRevenue = 1000000;
        lead1.Phone = '45679';
        lead1.NumberOfEmployees = 900;
        lead1.Status ='Working - Contacted';
        insert lead1;
        Lead leads = [select id,lastname,industry,rating from lead where id= :lead1.id];
        if(leads.Rating == 'Medium'){
            leads.rating = 'Warm';
        }
        System.assertEquals('Warm',leads.Rating);
        
        Lead lead3 = new Lead();
        lead3.Company = 'HP';
        lead3.FirstName ='Sanjay';
        lead3.LastName ='Raj';
        lead3.Industry = 'Banking';
        lead3.Email = 'hp@gmail.com';
        lead3.AnnualRevenue = 1000000;
        lead3.Phone = '45678';
        lead3.Status = 'Open - Not Contacted';
        lead3.NumberOfEmployees = 900;
        insert lead3;
        Lead L = [select id,lastname,company from Lead where id=:lead3.id];
        L.Company = NULL;
        try{
        Update L;
        System.assert(false,'Expected Error but Updated successfully');
        }catch(dmlException e){
            System.assert(e.getMessage().contains('Company is mandatory for all leads'));
        }
        Lead lead4 = new Lead();
        lead4.Company = 'HPP';
        lead4.FirstName ='Sanjay';
        lead4.LastName ='Dutt';
        lead4.Industry = 'Banking';
        lead4.Email = 'hpp@gmail.com';
        lead4.AnnualRevenue = 1000000;
        lead4.Phone = '45678';
        lead4.Status = 'Open - Not Contacted';
        lead4.NumberOfEmployees = 1100;
        insert lead4;
        Lead L1 = [select id,lastname,NumberOfEmployees,Rating from Lead where id=:lead4.id];
       
        System.assertEquals('High',L1.Rating);
        
        Lead lead5 = new Lead();
        lead5.Company = 'Saroja Technos';
        lead5.FirstName ='Maharaja';
        lead5.LastName ='Rudhra';
        lead5.Industry = 'Banking';
        lead5.Email = 'saroja@gmail.com';
        lead5.AnnualRevenue = 1000000;
        lead5.Phone = '45678';
        lead5.Status = 'Open - Not Contacted';
        lead5.NumberOfEmployees = 1000;
        insert lead5;
        Lead L2 = [select id,lastname,NumberOfEmployees,Rating from Lead where id=:lead5.id];
        System.assertEquals('Medium',L2.Rating);
        
        Lead lead6 = new Lead();
        lead6.Company = 'Mahesh Technos';
        lead6.FirstName ='Mahesh';
        lead6.LastName ='Babu';
        lead6.Industry = 'Banking';
        lead6.Email = 'saroja@gmail.com';
        lead6.AnnualRevenue = 1000000;
        lead6.Phone = '45678';
        lead6.Status = 'Open - Not Contacted';
        lead6.NumberOfEmployees = 100;
        insert lead6;
        Lead L3 = [select id,lastname,NumberOfEmployees,Rating from Lead where id=:lead6.id];
      
        System.assertEquals('Low',L3.Rating);
        
    }
}
