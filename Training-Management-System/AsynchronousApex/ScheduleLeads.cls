public class ScheduleLeads implements Schedulable {
    public void execute(SchedulableContext sc){
        
        //now call the Lead Queue
       System.enqueueJob(new  QueueLeads());
        
        
    }

}
