public class QueueThree implements Queueable{
    public void execute(QueueableContext context){
        //delete course records
 delete[select id,name,new_fee__c from Course__c where new_fee__c <40000];
        
    }
}
