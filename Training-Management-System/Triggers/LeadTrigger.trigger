trigger LeadTrigger on Lead (before insert,before update,After insert,after update) {

/*When a Lead is converted to Account/Contact
If the Lead’s Industry = ‘Technology’, automatically create a related Opportunity with:
Stage = “Prospecting”
Amount = Lead’s Annual Revenue
Otherwise, do not create any Opportunity*/
    
    if(Trigger.isAfter && Trigger.isUpdate){
        list<Opportunity> opps = new list<Opportunity>();
        for(Lead lead :Trigger.new){
         Lead oldLead  = Trigger.oldMap.get(lead.id);
            if(!oldLead.isConverted && lead.Industry == 'Technology' && lead.IsConverted){
                Opportunity opp = new Opportunity();
                opp.Name = lead.Name + ' Test Deal';
                opp.StageName = 'Prospecting';
                opp.Amount = lead.AnnualRevenue;
                opp.CloseDate = Date.today().addDays(30);
                opp.AccountId = lead.ConvertedAccountId;
                opps.add(opp);
            }
        }
        insert opps;
    }

   //Update the lead rating to Medium if the lead industry is Banking otherwise the rating should be warm

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
      // list<Lead> newLeads = Trigger.New;
           for(Lead newLead : Trigger.new){
               if(newLead.Industry == 'Banking'){
                   newLead.Rating = 'Hot';
                   
          } 
            
               else{
                   newLead.Rating ='Warm';
               }
       } 
        
    }
 /*When a new Lead is created or updated:

If Number of Employees > 1000 → set Lead Priority = 'High'

If Number of Employees between 500–1000 → set Lead Priority = 'Medium'

If Number of Employees < 500 → set Lead Priority = 'Low'

If Company field is blank → throw an error: “Company is mandatory for all leads.*/
    if(Trigger.isBefore && Trigger.isInsert || Trigger.isUpdate){
        for(Lead newlead : Trigger.new){
            
            if(newlead.Company == Null || newlead.Company==''){
                newlead.addError('Company is mandatory for all leads');
            } 
            
            if(newlead.NumberOfEmployees > 1000){
                newlead.Rating = 'High';
            }
            else if(newlead.NumberOfEmployees >= 500 && newlead.NumberOfEmployees <= 1000){
                newlead.Rating = 'Medium';
            }
            else{
                newlead.Rating ='Low';
            }
         
            
        }
        
    }
    
}
