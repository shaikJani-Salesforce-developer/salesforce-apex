@isTest // test class /calling point
public class EmployeeTest {
    // test class should consist of methods like class
    // ()this represents methods
    // now define test methods
 public  static testMethod void main(){
        // test class execusion start with main () method
        // type of testMethod is static
        // keyword of testMethod is testMethod
        // testMethod return_type is void
        //  now create the object ==> for calling the class --> syntax className objName = new className();
                              Employee emp1 = new Employee();
     // new object is created named as emp1
     // constructor ==> loading the properties or values in object
     // class has 2 methods --> call 2 methods from calling point 
     // for calling methods we have sintax --> objName.memMethod(argument 1,argument 2,...)
                                    emp1.setValues('Raghu',20000,'Manager','Btech','8989898989');  //string emp_name, decimal sal,string role,string qualif ,string contact
                                     emp1.getValues();
        //data/properties ia always private -->(abstraction level)
        //instructions is always public ---> (abstraction level)
         // create another object --> className objName =new className ();
                                      Employee emp2 = new Employee();
     // new object is created named as emp2
     // constructor ==> loading the values or properties into object
     // class has 2 methods ==> call 2 methods from calling point 
     // synatx for calling methods --> objName.memMethod(arguments1 ,arguments 2,..)
                                   emp2.setValues('Sharmila',40000,'GM','Mtech','9090909090');
                                      emp2.getValues();
                                  
     
     
    }
    
    @isTest static void testupdatedsalary(){
        
        Employee emp1 = new Employee();
        emp1.updatedsalary();
        emp1.setValues('Jyothi', 10000, 'Manager','MCA' ,'8008840960');
        Decimal finalupdatedsalary = emp1.updatedsalary();
        System.assertEquals(10500,finalupdatedsalary); 
        
        Employee emp2 = new Employee();
        emp2.updatedsalary();
        emp2.setValues('Virat', 40000, 'GM', 'MBA', '8008841961');
        Decimal finalupdatedsalary1 = emp2.updatedsalary();
        System.assertEquals(44000,finalupdatedsalary1);
        
        Employee emp4 = new Employee();
        emp4.updatedsalary();
        emp4.setValues('Sameer', 60000, 'HR', 'MBA', '8008841951');
        Decimal finalupdatedsalary2 = emp4.updatedsalary();
        System.assertEquals(69000,finalupdatedsalary2);
    } 

  @isTest static void testEmployeePromotion(){
        Employee emp1 = new Employee();
       
      emp1.setValues('Rithika', 60000, 'Manager','MSC', '8297620595');
      emp1.promoteEmployee();
      System.assertEquals('SeniorManager',emp1.designation);
      
      Employee emp2 = new Employee();
      
      emp2.setValues('Charan', 20000, 'developer', 'Btech', '7989569461');
      emp2.promoteEmployee();
      System.assertEquals('Juniordeveloper',emp2.designation);
      
    }
    @isTest static void testNewSalary(){
        Employee emp1 = new Employee();
        emp1.setValues('Megha',50000 , 'Admin', 'Mtech', '9848042919');
        Decimal TotalNewSalary = emp1.salaryhike(1);
        System.assertEquals(52500,TotalNewSalary);
        
        Employee emp2 = new Employee();
        emp2.setValues('Meghana',60000 , 'Sub Junior', 'Btech', '9848072929');
        Decimal TotalNewSalary1 = emp2.salaryhike(4);
        System.assertEquals(66000,TotalNewSalary1); 
        
        Employee emp4 = new Employee();
        emp4.setValues('Prabhu',60000 , 'Manager', 'Btech', '9848072829');
        Decimal TotalNewSalary2 = emp4.salaryhike(8);
        System.assertEquals(69000,TotalNewSalary2);
        
        Employee emp5 = new Employee();
        emp5.setValues('Bhai',100000 , 'Manager', 'Mtech', '9848072819');
        Decimal TotalNewSalary4 = emp5.salaryhike(11);
        System.assertEquals(120000,TotalNewSalary4);
        
        
    }
    
    @isTest static void testEmployeePerformance(){
        Employee emp1 = new Employee('Manoj',100000 , 'Manager', 'Mtech', '9848172819');
       Decimal NewSalary = emp1.calSalary('Outstanding');
        System.assertEquals(105000,NewSalary);
        
         Employee emp2 = new Employee('Vishnu',90000 , 'GM', 'Btech', '8848172819');
       Decimal NewSalary1 = emp2.calSalary('Good');
        System.assertEquals(91800,NewSalary1);
        
        
    Employee emp4 = new Employee('Vishal',50000 , 'GM', 'Btech', '7848172819');
       Decimal NewSalary2 = emp4.calSalary('average');
        System.assertEquals(50000,NewSalary2);
                
        
        
        
    }
}
