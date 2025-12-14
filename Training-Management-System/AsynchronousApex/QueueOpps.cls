public class QueueOpps implements Queueable {
    public void execute(QueueableContext context){
        /*Update the Opportunity stage at the end of the day
The Opportunity records created everyday if opp stage is not closed won → update it to closed won
*/
     list<Opportunity> opps = [select id,name,stagename,CreatedDate from Opportunity where CreatedDate = TODAY and StageName != 'Closed Won'];
        
        for(Opportunity opp : opps){
            opp.stagename = 'Closed Won';
        }
        update opps;
    }
}
