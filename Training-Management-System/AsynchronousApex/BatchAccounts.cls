public class BatchAccounts implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext startContext){
        //“Increase the AnnualRevenue by 10% for all Accounts whose Industry is ‘Technology’.”
     String accounts  = 'select id,name,Industry,Annualrevenue from Account where industry = \'Technology\'';
        return Database.getQueryLocator(accounts);
    }
    public void execute(Database.BatchableContext executeContext,list<sObject> accList){
        list<Account> accsToUpdate = new list<Account>();
        if(!accList.isEmpty()){
            for(sObject account :accList){
             Account eachAccount  = (Account) account;
                eachAccount.AnnualRevenue = eachAccount.AnnualRevenue+ (eachAccount.AnnualRevenue *10)/100;
                accsToUpdate.add(eachAccount);
            }
            if(!accsToUpdate.isEmpty()){
                //update accsToUpdate;
                Database.SaveResult[] results = Database.Update(accsToUpdate,false);
                for(Database.SaveResult result :results){
                    if(result.isSuccess()){
                        System.debug('Account Updated Successfully :'+result.getId());
                    }
                    else{
                        for(Database.Error error :result.getErrors()){
                            System.debug('Get Status Code :'+error.getStatuscode());
                            System.debug('Error message :'+error.getMessage());
                            System.debug('Get Error fields :'+error.getfields());
                        }
                    }
                }
        }
        } 
    }
    public void finish(Database.BatchableContext finishContext){
        //track the job details about the job that is performed
        System.debug('Job Done');
        System.debug('Job id :'+finishContext.getJobid());
        AsyncApexJob details = [select id,Status,NumberOfErrors,JobItemsProcessed,TotalJobItems,createdBy.Email
                                From AsyncApexJob where id=:finishContext.getJobId()];
        
    }
}
