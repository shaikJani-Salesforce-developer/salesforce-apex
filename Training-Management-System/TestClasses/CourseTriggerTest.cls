@istest
public class CourseTriggerTest {
    @istest static void testCoursetrigger(){
    Course__c course = new Course__c();
    course.Name = 'Java';
    course.New_Fee__c = 25000;
    course.Old_Fee__c = 20000;
    course.Availablility__c = 'Online';
    insert course;
     Course__c updatecourse  = [select id,name,new_fee__c,old_fee__c,Availablility__c from Course__c where id =:course.id];
        updatecourse.Availablility__c = 'Offline';
        try{
        update updatecourse;
        System.assert(false,'expected error but updated successfully');
        }catch(dmlException e){
            System.assert(e.getMessage().contains('Course Availablity Should Be Online Only'));
        }
        
        Course__c course1 = new Course__c();
    course1.Name = 'HTML';
    course1.New_Fee__c = 25000;
   
    course1.Availablility__c = 'Online';
    
   
        try{
        insert course1;
        System.assert(false,'Expected error but inserted successfully');
        }catch(dmlException e){
            System.assert(e.getMessage().contains('Enter Course Old Fee'));
        }
        
        
      }
   @istest static void testCourseStatus(){
        Course__c course = new Course__c();
        course.Name = 'Java Script';
        course.New_Fee__c = 4000;
        course.Old_Fee__c = 3000;
        course.Availablility__c ='Online';
        insert course;
     Course__c upcourse = [select id,name,Approval_Status__c,new_fee__c from Course__c where id = :course.Id];
       System.assertEquals('Rejected',upcourse.Approval_Status__c);
       
       Course__c course1 = new Course__c();
        course1.Name = 'SAP';
        course1.New_Fee__c = 14000;
        course1.Old_Fee__c = 13000;
        course1.Availablility__c ='Online';
        insert course1;
     Course__c updatecourse = [select id,name,Approval_Status__c,new_fee__c from Course__c where id = :course1.Id];
       System.assertEquals('Pending',updatecourse.Approval_Status__c);
       
       Course__c course2 = new Course__c();
    course2.Name = 'Service now';
    course2.New_Fee__c = 25000;
    course2.Old_Fee__c = 20000;
    course2.Availablility__c = 'Online';
    insert course2;
     Course__c updatecourse1  = [select id,name,new_fee__c,Approval_Status__c from Course__c where id =:course2.id];
       System.assertEquals('Accepted',updatecourse1.Approval_Status__c);
       
       
       Course__c course3 = new Course__c();
    course3.Name = 'Service now';
    course3.New_Fee__c = 25000;
    course3.Old_Fee__c = 20000;
    course3.Availablility__c = 'Online';
       course3.Approval_Status__c = 'Accepted';
    insert course3;
     Course__c deletecourse  = [select id,name,new_fee__c,old_fee__c,availablility__c,approval_status__c from Course__c where id =:course3.id];
       try{
       delete deletecourse;
           System.assert(false,'expected error but deleted successfully');
       }catch(dmlException e){
           System.assert(e.getMessage().contains('You Cannot delete the Accepted Record'));
       }
    }
    }
