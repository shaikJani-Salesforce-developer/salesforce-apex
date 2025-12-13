trigger LeadTrigger on Lead (before insert,before update) {

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
