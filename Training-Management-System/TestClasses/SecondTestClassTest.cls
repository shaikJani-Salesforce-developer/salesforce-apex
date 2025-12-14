@isTest
public class SecondTestClassTest {

   @isTest static void testsetvalues(){
        
        SecondTestClass.setValues(); 
       System.assertEquals('Hot',SecondTestClass.rating);
       System.assertEquals('Phone',SecondTestClass.leadsource);
       System.assertEquals('Banking',SecondTestClass.industry);
       
        
    }
    @isTest static void testbasicinfo(){
        
        SecondTestClass obj = new SecondTestClass();
        obj.basicinfo();
        System.assertEquals('Raghu',obj.name);
        System.assertequals(25,obj.age);
        
      
        obj.marks = 45;
          obj.studentprogress();
        System.assertEquals('You are Passed',obj.description);
        System.assertEquals('Pass',obj.status);
        
        
        obj.marks = 25;
        obj.studentprogress();
        system.assertEquals('You are failled',obj.description);
        System.assertEquals('Fail',obj.status); 
    }
}
