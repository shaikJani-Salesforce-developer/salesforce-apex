public class ScheduleApex implements Schedulable {
    public void execute(SchedulableContext sc){
        
        //now call Queue Opps 
        System.enqueueJob(new QueueOpps());
        
        // now call the Queue Accounts job
        System.enqueueJob(new QueueAccounts());
    
    }
    
}
