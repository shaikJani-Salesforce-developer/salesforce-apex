public class QueueTwo implements Queueable {
    public void execute(QueueableContext context){
        
        //insert books
       Book__c book1 = new Book__c();
        book1.name = 'Sravani';
        book1.Author_Name__c = 'Raja';
        book1.Price__c= 900;
        
        Book__c book2 = new Book__c();
        book2.name = 'Jyothi';
        book2.Author_Name__c = 'RaJ';
        book2.Price__c= 900;
        
        list<Book__c> books = new list<Book__c>();
        books.add(book1);
        books.add(book2);
        insert books;
            //now call the job 3
           System.enqueueJob(new QueueThree());
    }
}
