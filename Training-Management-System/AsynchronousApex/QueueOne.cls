public class QueueOne implements Queueable {
    public void execute(QueueableContext  context){
        
        //update lead rating to 'Hot .. which lead city is US
     list<Lead> leads  = [select id,name,rating,city from Lead where city = 'US'];
        
        for(Lead lead : leads){
            lead.Rating = 'Hot';
            
        }
        update leads;
        //call job 2
      System.enqueueJob(new QueueTwo());
        
        
    }
}
