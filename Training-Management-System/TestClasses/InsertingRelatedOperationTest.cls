public class InsertingRelatedOperation{

   public static void InsertingRelatedCustomRecords(){
        //student, course,trainer,placement objects are in relationship
        //student is child object --> course,trainer,placements are parent objects
        //if we wanna insert student record --> we should have parent records already in model
        //step1 insert parent records
        //step2 insert child records 
        //for inserting record --> we need memory space --> for space create the object
        //syntax --> className obj = new className();
        //loading values --> obj.fieldname = value;
        Course__c course1 = new Course__c();
        course1.Name ='ChatGPT';
        course1.Old_Fee__c = 20000;
        course1.New_Fee__c = 25000;
        course1.Availablility__c = 'Online';
       // now perform insert operation
       // syntax --> insert course1;
         insert course1;
       //if statement
       if(course1.id !=null){
           System.debug('Course Record :'+course1);
       }
        
       //Now insert trainer record --> for inserting we need memory space
       //for memory space create the object 
       //syntax --> className obj = new className();
       //loading the values --> obj.fieldname =value;
         Trainer__c trainer1 = new Trainer__c();
           trainer1.Name = 'Suresh Mohan';
           trainer1.Gender__c = 'Male';
           trainer1.Qualification__c ='B.tech';
           trainer1.Date_of_birth__c = Date.newInstance(1985, 12, 19);
           trainer1.Mobile__c = '8008840960';
           trainer1.Phone__c = '24567';
           trainer1.Salary__c = 40000;
           trainer1.Email__c ='suresh@gmail.com';
           trainer1.Address__c = 'Begumpet Hyderabad';
           trainer1.PAN_Number__c = 'AAJFN2489N';
       // now perform insert operation
       // syntax --> insert trainer1;
        insert trainer1;
          // if statement 
       if(trainer1.id !=null){
           System.debug('Trainer record :'+trainer1);
       }
       
       // now insert Placement record --> for inserting we need memory space
       // for space create the object --> className obj = new className();
       // loading the values --> obj.fieldName = value;
              Placements__c placement1 = new Placements__c();
             placement1.Name = 'Infosys';
       // perform insert operation
          insert placement1;
       //if statement
       if(placement1.id !=null){
           System.debug('Placement is :'+placement1);
       }
       
       // now insert student child record --> for inserting we need a space
       // for space create the object --> syntax --> className obj = new className();
       // loading the values --> obj.fieldname = value;
        Student__c student1 = new Student__c();
        student1.Name = 'Ramesh Sen';
        student1.Gender__c ='Male';
        student1.Date_of_birth__c =Date.newInstance(2000, 2, 2);
        student1.Course__c = course1.id;
        student1.Trainer__c = trainer1.id;
        student1.Placements__c = placement1.id;
        student1.Phone__c = '24567';
        student1.Mobile__c = '9090909090';
       student1.State__c = 'Telangana';
       student1.City__c = 'Khammam';
       student1.Qualification__c = 'B.tech';
        student1.Salary__c = 25000;
        student1.Email__c = 'ramesh@gmail.com';
        student1.Address__c = 'Kukatpally hyderabad';
        student1.RecordTypeId = '012gL000001r4mYQAQ';
       student1.Account_Number__c = '24657890146';
       // now perform insert operation
         insert student1;
       // if statement
       if(student1.id !=null){
           System.debug('Student :'+student1);
       }
        
       
       
       
       
    }
    
    
}
