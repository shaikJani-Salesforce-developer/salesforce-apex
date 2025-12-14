public class QueueLeads implements Queueable {
    public void execute(QueueableContext context){
       //Every Friday at 10 AM, check all Lead records with Status = 'Open' and LastActivityDate = NULL, 
       //then update a custom checkbox Follow_Up_Required__c = true. 
        list<Lead> leads = [select id,Status,LastActivityDate,Follow_Up_Required__c from Lead Where Status = 'Open - Not Contacted' and LastActivityDate = NULL];
        if(!leads.isEmpty()){
            for(Lead lead : leads){
                lead.Follow_Up_Required__c = true;
            }
            update leads;
        }
    }
}
