public class BatchBooks implements Database.Batchable<sObject> {
    public database.QueryLocator start(Database.BatchableContext  startContext){
        //initiate the process 
        //fetch the book records 
      String books = 'select id,name,price__c from Book__c where price__c<1000';
        return database.getQueryLocator(books);
    }
    public void execute(database.BatchableContext executeContext, list<sObject> upbooks){
        list<Book__c> booksUpdate = new list<Book__c>();
        if(!upbooks.isEmpty()){
            for(sObject book:upbooks){
              Book__c updateBook = (Book__c) book;
                updateBook.price__c += 1000;
                booksUpdate.add(updateBook);
        }
            if(!booksUpdate.isEmpty()){
                //update booksUpdate;
              DataBase.SaveResult[] results = Database.Update(booksUpdate,false);
                for(Database.SaveResult result :results){
                    if(result.isSuccess()){
                        System.debug('Successfully Updated book id :'+result.getId());
                    }
                    else{
                        for(Database.Error error : result.getErrors()){
                            System.debug('Get Status Code :'+error.getStatuscode());
                            System.debug('Error message :'+error.getMessage());
                            System.debug('Get Error fields :'+error.getfields());
                        }
                    }
                }
                
    }
    } 
    } 
    public void finish(database.BatchableContext finishContext){
        //will have the job id
        //track the details about the job that is performed
        System.debug('Job is  Done');
        System.debug('Id of the Job :'+finishContext.getJobid());
        AsyncApexJob details = [select id,Status,NumberOfErrors,JobItemsProcessed,TotalJobItems,createdBy.Email From AsyncApexJob where id=:finishContext.getJobId()];
        
        //send a eamil that the job is finished
    }
}
