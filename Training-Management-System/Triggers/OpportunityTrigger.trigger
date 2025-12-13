trigger OppTrigger on Opportunity (before insert,before update) {
//Opportunity stage should be prospecting and the close date should be 15 days from the day that is given

    
    if(Trigger.isBefore && Trigger.isInsert){
       // list<Opportunity> newOpps = Trigger.New;
        for(Opportunity newOpportunity : Trigger.new){
            newOpportunity.StageName = 'Prospecting';
            newOpportunity.Closedate = Date.today().adddays(15); 
            
        } 
        
    }
    /*When a new Opportunity is created or updated,
the Close Date should not be more than 90 days from today’s date.

If the Close Date is greater than 90 days from today,
throw an error saying:
“Close Date cannot be more than 90 days from today.”*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Opportunity newOpp : Trigger.New){
            if(newOpp.Closedate > Date.today().adddays(90)){
                newOpp.addError('Close Date cannot be more than 90 days from today');
            }
        }
        
        
    }
    /*When a new Opportunity record is created or updated,
if the Amount is less than or equal to 0, show an error:
“Amount must be greater than zero.”

If the Stage Name is ‘Closed Won’, then Probability should be 100 automatically.

If the Stage Name is ‘Closed Lost’, then Probability should be 0 automatically.*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Opportunity newOpp : Trigger.New){
            if(newOpp.amount == NULL || newOpp.Amount <= 0){
                newOpp.addError('Amount must be greater than zero');
            }
            if(newOpp.StageName == 'Closed Won'){
                newOpp.Probability = 100;
            }
            else if(newOpp.StageName == 'Closed Lost'){
                newOpp.Probability = 0;
            }
        }
    }
    
    /*When a new Opportunity is created or updated:

If CloseDate is in the past → throw an error: "Close Date cannot be in the past."

If Amount is greater than 500,000 → set Opportunity_Type__c = 'Big Deal'

If Amount is between 100,000 and 500,000 → set Opportunity_Type__c = 'Medium Deal'

If Amount is less than 100,000 → set Opportunity_Type__c = 'Small Deal'*/
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Opportunity newOpp : Trigger.New){
            if(newOpp.Amount > 500000){
                newOpp.Opportunity_Type__c = 'Big Deal';
            }
            else if(newOpp.Amount >= 100000 && newOpp.Amount <= 500000){
                newOpp.Opportunity_Type__c = 'Medium Deal';
            }
            else{
                 newOpp.Opportunity_Type__c = 'Small Deal';
            }
            if(newOpp.CloseDate != null && newOpp.CloseDate < Date.today()){
                newOpp.addError('Close Date cannot be in the past');
            }
        }
    }
}
