public class BatchOppsTotalAmount implements Database.Batchable<sObject>, Database.Stateful {
    //calculate the total amount from opportunity
    Decimal totalAmount = 0.0;
    public Database.QueryLocator start(Database.BatchableContext startContext){
        //fetch opportunities amounts those amount not equal to null
      String amountOpps ='Select id,Name,Amount from Opportunity Where Amount != null';
        return Database.getQueryLocator(amountOpps);
    }
    public void execute(Database.BatchableContext executeContext, list<sObject> opportunities){
        if(!opportunities.isEmpty()){
            for(sObject opportunity :opportunities){
              Opportunity oppsAmount = (Opportunity)opportunity;
                totalAmount += oppsAmount.Amount;
            }
        }
    }
    public void finish(Database.BatchableContext finishContext){
        //track the details about the job that is performed
        System.debug('Job Is Done');
        System.debug('Job Id :'+finishContext.getJobid());
        AsyncApexJob details = [select id,Status,NumberOfErrors,JobItemsProcessed,TotalJobItems,createdBy.Email
                                From AsyncApexJob where id=:finishContext.getJobId()];
        System.debug('Total Opportunities Amount :'+totalAmount);
    }
}
