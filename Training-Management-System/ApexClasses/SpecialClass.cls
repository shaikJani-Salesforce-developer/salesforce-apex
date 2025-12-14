public class SpecialClass {
public static void upopportunities(){
        //Requirement:
//If an Opportunity has Stage = ‘Prospecting’ and Amount > 50,000, update Stage = ‘Qualification’.
//If an Opportunity has Stage = ‘Negotiation/Review’ and CloseDate < Today, update Stage = ‘Closed Lost’.
                    
                     
           list<Opportunity> opportunities =[select id, Name, StageName, Amount from Opportunity where StageName = 'Prospecting' and Amount >50000];
        if(!opportunities.isEmpty()){
            for(Opportunity opportunity : opportunities){ 
                
                
                    if(opportunity.StageName=='Prospecting' && opportunity.Amount > 50000){
                        opportunity.StageName = 'Qualification';
                    }
                } 
            
                     update opportunities;
        } 
          


                     Date myday;
                     myday = Date.today();
        list<Opportunity> opportunities1 = [select id, Name,StageName,CloseDate from Opportunity where StageName ='Negotiation/Review' and CloseDate < :myday];
        if(!opportunities1.isEmpty()){
            
            for(Opportunity opportunity : opportunities1){
                
                if(opportunity.StageName == 'Negotiation/Review' && opportunity.CloseDate < myday){
                    opportunity.StageName = 'Closed Lost';
                }
                
            }
            update opportunities1; 
            
        }
        
        
    }
    
    public static void upcontact(){
        
        //If a Contact’s Email ends with @gmail.com, update its LeadSource = 'Web'.
//If a Contact’s Email ends with @yahoo.com, update its LeadSource = 'Partner Referral'.
        list<Contact> contacts = [select id, Salutation,FirstName,LastName,Email,LeadSource from Contact Where Email Like '%@gmail.com'OR Email Like '%@yahoo.com'];
        if(!contacts.isEmpty()){
            
            for(Contact contact : contacts){
                if(contact.Email !=null){
                    if(contact.Email.endsWith('@gmail.com')){
                       contact.LeadSource = 'Web';
                    } 
                    else if(contact.Email.endsWith('@yahoo.com')){
                        contact.LeadSource = 'Partner Referral';
                    }
                    
                } 
                
                
            }
                
                  update contacts;
        }
        //Requirement:
//If a Case’s Origin = 'Web' and Priority = 'High', update Status = 'Escalated'.
//If a Case’s Origin = 'Phone' and Priority = 'Low', update Status = 'Closed'.
                   
list<Case> cases2  = [select id,Origin,Priority,Status from Case where Origin IN('Web','Phone') and Priority IN('High','Low')];
              
        for(Case eachcase :cases2){
            if(eachcase.Origin =='Web' && eachcase.Priority == 'High'){
                eachcase.status = 'Escalated';
                
            }
            else if(eachcase.Origin == 'Phone' && eachcase.Priority == 'Low'){
                eachcase.Status = 'Closed';
                
            }
        }
        
                    update cases2;
   
    
    }
   public static void upaccount(){
        
        // Requirement

//If an Account’s Industry = 'Technology' and AnnualRevenue > 1,000,000, update its Rating = 'Hot'.
//If an Account’s Industry = 'Finance' and AnnualRevenue < 500,000, update its Rating = 'Cold'.  
        list<Account> accounts4 = [select id,Name,industry,AnnualRevenue,Rating from Account where Industry IN('Technology','Finance')];
            
        for(Account account : accounts4){
            
            if(account.Industry == 'Technology' && account.AnnualRevenue>1000000){
                
                account.Rating = 'Hot';
            } 
            else if(account.Industry== 'Finance' && account.AnnualRevenue < 500000){
                account.Rating = 'Cold';
            }
        }
            update accounts4;
    }
}
