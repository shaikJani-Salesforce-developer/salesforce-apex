@isTest //test class / calling point
// test class has methods like class
// () this represents methods 
// now define test method


public class StudentTest { 
   public static testMethod void main(){ 
        //create the object ==> call the class ==> syntax ==> className objName = new className();
                                   Student stu1 = new Student();
       // new object is created named as stu1
       // constructor ==> load the values into object 
       // now call the 2 methods which defined in class ==> input , output 
       // iam calling the 2 methods from calling point ==> syntax ==> obj.memMethod(arguments1,arguments2,...);
                    stu1.setValues('rahul','male',Date.newInstance(1997, 4, 15),5,'8008840960');     //string stn,string gen,date dob ,integer cla,string contact)
                    stu1.getValues();
                    Student.schooltime();
       // data is always ==> private (abstraction level)
       // instructions ==> public (abstraction level )
       // create another object ==> syntax => className objName = new classname();
                                              Student stu2 = new Student();
       // new object is created named as stu2 
       // constructor ==> duty ==> loading the values into object 
       // now call methods from calling point --> 2 methods in class --> syntax--> objName.memMethod(arguments1,arguments2,...)
                                               stu2.setValues('ramya','female',Date.newInstance(1996,5,15),6,'897657890');
                                               stu2.getValues();
                                               Student.schooltime();
       // now another object -->syntax --> className objName = new className();
                                          Student stu3 = new Student();// null state
       // calling 2 methods from calling point --> syntax --> objName.memMethod(argument1 ,argument 2,..);
                                           
                                           stu3.getValues(); // null values 
                                           stu3.setValues('rafi','male',Date.newInstance(1999,9,19),9,'6060606060');
                                           stu3.getValues();
                                           Student.schooltime();
       // create another object
                                            Student stu4 = new Student('raheem','male',Date.newInstance(2000,8,15),2,'6060606061');
                                            stu4.getValues();
                                             Student.schooltime();
              
       // create the object  
                                Student stu5 = new Student();
                             stu5.setValues('Reehana','Female',Date.newInstance(1995,8,15),2,'6460646061');
                              Integer age = stu5.calAge();
                              stu5.getValues();
                              System.debug('Student Age :'+age);
       // create the object 
                    Student stu6 = new Student();
                      stu6.setValues('Sharmila','Female',Date.newInstance(1994,8,15),5,'6450646561');
                      stu6.PromoteStudent();
                      stu6.getValues();
       // create the object 
                Student stu7 = new Student();
                      stu7.setValues('Oorvasi','Female',Date.newInstance(2015,8,15),6,'6455646561');
                      stu7.Eligibility4Exam();
                      stu7.getValues();
       // 
                   Student stu8 = new Student();
                      stu8.setValues('Subbu','Male',Date.newInstance(2014,8,19),4,'6255646571');
                      stu8.UpdateContact('8008840960');
                      stu8.getValues();
       
       // 
                          Student stu9 = new Student();
                     stu9.setValues('Jyothi','Female',Date.newInstance(2016,9,5),4,'6956465701');
                     stu9.getValues();
                     Student.schooltime();
       //
       
          Student stu10 = new Student();
                     stu10.setValues('Apsara','Female',Date.newInstance(2012,1,1),4,'6156465601');
                     stu10.getValues();
                     String status = stu10.AttendanceChecking(time.newInstance(8,0,0,0));
                     Student.schooltime();
       
       
             //         
       Student stu11 = new Student();
                     stu11.setValues('Narasimha','male',Date.newInstance(2012,1,1),4,'6000465601');
                     stu11.getValues();
                     String grade = stu11.gradingsystem(40);
                     Student.schooltime();
                     System.debug('Student Grade :'+grade);
       
    } 
    
    @isTest static void testAttendanceChecking(){
        Student student1 = new Student();
        student1.setValues('Annamma', 'Female', Date.newInstance(2012,1,1), 5, '8008840960');
        String status = student1.AttendanceChecking(null);
        System.assertEquals('absent',status);
        
        Student student2 = new Student();
        student2.setValues('seetha', 'Female', Date.newInstance(2012,1,7), 5, '7008840960');
        String status2 = student2.AttendanceChecking(time.newInstance(9,0,0,0));
        System.assertEquals('On Time',status2);
        
        Student student4 = new Student();
        student4.setValues('Rama', 'Female', Date.newInstance(2012,1,8), 6, '6008840960');
        String status4 = student4.AttendanceChecking(time.newInstance(10,0,0,0));
        System.assertEquals('Late',status4);
        
    }
    
    @isTest static void testgrading(){
        Student student1 = new Student();
        student1.setValues('Roja','Female', Date.newInstance(2012,1,8), 5, '8008840960');
        String grade = student1.gradingsystem(90);
        System.assertEquals('A',grade);
        
        Student student2 = new Student();
        student2.setValues('Roja Sri','Female', Date.newInstance(2012,6,8), 6, '8018840960');
        String grade1 = student2.gradingsystem(80);
        System.assertEquals('B',grade1);
        
        Student student4 = new Student();
        student4.setValues('Rukmini','Female', Date.newInstance(2015,6,8), 6, '8118840960');
        String grade4 = student4.gradingsystem(60);
        System.assertEquals('C',grade4);
        
        Student student5 = new Student();
        student5.setValues('Rukmini Vasanth','Female', Date.newInstance(2016,6,8), 6, '8118740960');
        String grade5 = student5.gradingsystem(25);
        System.assertEquals('D',grade5);
    }

}
