@isTest //test class /calling point
public class CourseTest {
    //test class has methods like class
    //now define the test methods
    //() this represents the method
   static testMethod void testallcourses(){
       // here test class execusion starts from main() method
       // type of test method is static
       // keyword of testMethod is testMethod
       // testMethod return_type is void
       // now create the object ==> for calling the class ==> syntax==> className objName = new className();
                         Course cou1 = new Course();
       // new object is created named as cou1
       // constructor --> duty --> loading the properties or values into object
       // 2 methods defined in class 
       // now call the 2 methods from calling point 
       // for calling the methods we have syntax --> obj.memMethod(arguments 1,arguments 2,...);
                                             cou1.setValues('java',20000,25000,'Online',7);          //(string c_name ,decimal old , decimal new_fe,string avail)
                                             cou1.getValues();
        
        // data/properties is always private --> (abstraction level)
        // instructions is always public --> (abstraction level)
         // now creating another object --> syntax --> className objName = new className();
                                                       Course cou2 = new Course();
       // new object is created named as cou2 
       // constructor ==> duty --> loading properties or values into object
       // now calling 2 methods from calling point ==> syntax --> objName.memMethod(argument 1,argument2,..)
                                               cou2.setValues('salesforce',24000,26000,'Offline',7);
                                               cou2.getValues ();
                                               Course cou4 = new Course();
                                                cou4.getValues();
                                                cou4.setValues('HTML',28000,29000,'Offline',6);
                                                cou4.getValues();
                                            Course cou5 =new Course('Powerbi',16000,15000,'Offline',5);
                                             cou5.getValues();
                                           
        // create new object for discount action method
                                                   Course cou6 = new Course();
                                                
                                                cou6.setValues('Physics',28000,29000,'Offline',5);
                                                Decimal newUpdatedfee = cou6.DiscountRules();
                                                cou6.getValues();
                                               System.debug('Course New Updated Fee :'+newUpdatedfee);
                                         
       
       // create the object 
                                                   Course cou7 = new Course();
                                                
                                                cou7.setValues('Chemistry',48000,29000,'Offline',5);
                                                Decimal newUpdatedfee1 = cou7.DiscountRules();
                                                 cou7.extendDuration(4);
                                                cou7.getValues();
                                               System.debug('Course New Updated Fee :'+newUpdatedfee1);
       
       // create the object
                                  Course cou8 = new Course();
                                cou8.setValues('Geo Technology', 5000, 6000, 'Online', 2);
                                    Decimal newUpdatedfee2 = cou8.DiscountRules();
                                 cou8.getValues();
                                   System.assertEquals(5700,newUpdatedfee2); 
       // create the object 
                           Course cou9 = new Course();
                         cou9.setValues('ChatGPT Plus', 12000, 15000, 'Online',4);
                             Decimal newUpdatedfee4 = cou9.DiscountRules();
                          cou9.getValues();
                         System.assertEquals(13500,newUpdatedfee4);
       //create the object 
                         Course cou10 = new Course();
                         cou10.setValues('Copilet',30000,50000, 'Online',9);
                             Decimal newUpdatedfee5 = cou10.DiscountRules();
                          cou10.getValues();
                         System.assertEquals(40000,newUpdatedfee5);
       
                               Course cou11 = new Course();
                         cou11.setValues('Microsoft',40000,50000, 'Online',10);
                             Decimal newUpdatedfee6 = cou11.DiscountRules();
                          cou11.getValues();
                         System.assertEquals(40000,newUpdatedfee5);
       
       
    }  

}
