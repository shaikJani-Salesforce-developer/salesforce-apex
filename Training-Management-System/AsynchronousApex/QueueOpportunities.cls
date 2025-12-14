public class QueueOpportunities implements Queueable {
    public void execute(QueueableContext context){
      /*Every 1st day of the month at 8 AM, 
check all Opportunities with StageName = 'Closed Won' and
Amount > 100000, then update a custom checkbox High_Value__c = true.*/
        list<Opportunity> opps = [select id,name,stagename,Amount,High_Value__c from Opportunity];
        list<Opportunity> oppsUpdate = new list<Opportunity>();
        if(!opps.isEmpty()){
            for(Opportunity opp :opps){
                if(opp.stagename == 'Closed Won' && opp.Amount > 100000){
                    opp.High_value__c = true;
                    oppsUpdate.add(opp);
                }
            }
            update oppsUpdate;
        }
    }
}
