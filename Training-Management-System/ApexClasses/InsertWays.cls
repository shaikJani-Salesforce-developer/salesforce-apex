public class InsertWays {
    
    public static void insertrecordsin5ways(){
        
        // we can insert records in 5 ways 
        // 1 way 
        // create the memory space --> for space create the object 
        // className obj = new className();
        // load the values 
        // obj.fieldname = value;
          Book__c book1 = new Book__c();
        book1.Name = 'King Akbar';
        book1.Author_Name__c = 'Mani';
        book1.Price__c = 700;
       // insert book1;
        
         Book__c book2 = new Book__c();
        book2.Name = 'King Shajahan';
        book2.Author_Name__c = 'Soorasen';
        book2.Price__c =800;
        //insert book2;
        // for inserting 2 records 2 dml statements performed
        // this is bad practise
        // now consider collections --> list collections
          list<Book__c> books = new list<Book__c>();
          // list methods --> add();
            books.add(book1);
            books.add(book2);
        
        if(!books.isEmpty()){
            insert books;
        }

         
      // insert records in  2nd way 
         Book__c book4 = new Book__c(Name = 'Aurangajeb', Author_Name__c = 'Raheem' , Price__c = 500);
         Book__c book5 = new Book__c(Name = 'Rana', Author_Name__c = 'Ram', Price__c = 700);
         Book__c book6 = new Book__c(Name = 'Rukmini',Author_Name__c = 'Roja',Price__c = 800);
        
        // add to list collection
         list<Book__c> Books1 = new list<Book__c>();
         books1.add(book4);
         books1.add(book5);
         books1.add(book6);
        // if statement 
        if(!books1.isEmpty()){
            insert books1;
        }
        
        // now 3rd way of inserting records 
        // directly insert in collection
        list<Book__c> books2 = new list<Book__c>();
         books2.add(new Book__c(Name = 'Naga Valli',Author_Name__c = 'Anushka',Price__c = 700));
        books2.add(new Book__c(Name = 'Kanchana',Author_Name__c = 'Lawrence',Price__c = 600));
        // if statement
        if(!books2.isEmpty()){
            insert books2;
        }
        
        //now 4th way of inserting records
       // by using list collection 
        list<Book__c> books4 = new list<Book__c>{
            new Book__c(Name ='RajaVamshi',Author_Name__c='Sikkim',Price__c = 900),
            new Book__c(Name = 'Japan',Author_Name__c = 'Karthi',Price__c = 1000)
        };
        
        if(!books4.isEmpty()){
            insert books4;
        }
        //5th way very import way using traditional loop 
        list<Book__c> books5 = new list<Book__c>();
        for(integer count =1; count<=10; count++){
            Book__c bookobj = new Book__c();
            bookobj.Name = 'Oorvasi'+count;
            bookobj.Author_Name__c = 'Raashi'+count;
            bookobj.Price__c = 200 * +count;
            // in for loop never do insert operation
            
         // we given 10 books in loop 
         // we should add these into collection 
              books5.add(bookobj);
        }
            insert books5;
    }

}
