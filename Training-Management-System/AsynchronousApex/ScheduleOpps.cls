public class ScheduleOpps implements Schedulable {
    public void execute(SchedulableContext sc){
        //call the Queue Opportunities
        System.enqueueJob(new QueueOpportunities());
    }
}
