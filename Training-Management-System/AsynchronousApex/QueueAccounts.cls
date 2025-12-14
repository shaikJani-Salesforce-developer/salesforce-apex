public class QueueAccounts implements Queueable {
    public void execute(QueueableContext context){
        //Business Rule:
//“Every Monday at 9 AM, check all Accounts with AnnualRevenue < 100000 and update Priority__c = 'Low'

list<Account> accountsToUpdate = [select id,AnnualRevenue,Priority__c from Account where AnnualRevenue <100000];
        if(!accountsToUpdate.isEmpty()){
            for(Account account : accountsToUpdate){
                account.Priority__c = 'Low';
            }
            update accountsToUpdate;
        }
    }
}
