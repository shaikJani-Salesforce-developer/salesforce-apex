public class Student {
    // public is abstraction or access specifier
    // class -> iam writing a class
    // student ->  className
    // class --> class is combination of two programming elements (data,instructions)
    // data/data members/properties ==> (student_name, gender,date_of_birth ,class_no,contact_no)
     private String student_name;
     private String gender;
     private date date_of_birth;
     private Integer class_no;
     private String contact_no;
      static time school_time = time.newInstance(9,0,0,0); //staic means constant/this is a static variable /school time is same for all
    // syntax ==> datatype name ;
    // instructions/methods/functions/member methods/behaviours ==> they will provide service to data members
    // values coming from the calling point to definition .. from definition to data members 
    /* syntax ==> public return_type methodName (datatype name 1,datatype name 2,...){
              ==> statements ==> perform the task }*/
    
    //--> 4 parts 
    // create --> loading initial values --> constructor
    // null --> dummy values --> meaningfull values --> default constructor 
    public Student (){
        // --> statements --> perform the statements 
        student_name ='no name';
            gender ='no gender';
            date_of_birth =Date.newInstance(2000, 11, 11);
        class_no =0;
        contact_no ='no number';
        
    }
    // null values --> meaningfull values
    // constructor + setValues = parameterized constructor
    // syntax for parameteraized constructor --> public Student(setValues)
     public Student (string stn,string gen,date dob ,integer cla,string contact){
               student_name =stn;
               gender =gen;
               date_of_birth = dob;
               class_no = cla;
               contact_no = contact;
    }
    // input --> duty is to load the values into data members
    // syntax
    // assignment operator 
   public void setValues (string stn,string gen,date dob ,integer cla,string contact){
               student_name =stn;
               gender =gen;
               date_of_birth = dob;
               class_no = cla;
               contact_no = contact;
    }
    
    // action/processing --> we can calculate the age --> for this what we need
    // date of birth , student name
    public Integer calAge(){
           Date today;
           today = Date.today();  
        Integer days = date_of_birth.daysBetween(today);
        Integer age = days/365;
        return age;
        
    }
    // promoting student / pramote to next class --> means increase by class 
    // what we require for this --> class, student name 
    public void PromoteStudent(){
           class_no++;
        System.debug(student_name+ 'is Pramoted to class :'+class_no);
    }

    // //Check Eligibility for Exam --> Rule: Student must be in class above 5
       //students who are above the class 5 they can write the exam
    public void Eligibility4Exam(){
        if(class_no > 5){
            System.debug(student_name+ ' is eligible for exam');
        }
        else{
            System.debug(student_name+ ' is Not eligible for exam');
        }
    } 
    //Action Method: Update Contact Number
    //Purpose: Update the student’s contact number when it changes.
    //for this what we require --> new contact is require --> pass new contact as input
    public void UpdateContact(string NewContact_no){
        contact_no = NewContact_no;
        System.debug('Student New Contact :' +contact_no);
    }
    
    //Action/processing --> student comes school late or intime or absent
    //for this we need name,school time , student attending time
    public String AttendanceChecking(time student_time){
           String status;
        
        if(student_time == null){
            status = 'absent';
        }
        else if(school_time == student_time){
            status = 'On Time';
        }
        else if(school_time < student_time) {
            status = 'Late';
        }
        else{
            status = 'Early';
        }
              
      System.debug(student_name+  ' is  ' +status);
        return status;
    } 
    
  
      /* Example rules:
                            90 – 100 → Grade A
                           75 – 89 → Grade B
                            50 – 74 → Grade C
                              < 50 → Fail */
   // grading system --> for this what we require --> 
   // student name , marks 
    public String gradingsystem(integer marks){
          String grade;
        if(marks>=90 && marks <=100){
              grade ='A';
        }
        else if(marks >=75 && marks<= 89){
            grade ='B';
        }
        else if(marks >= 50 && marks <= 74){
             grade ='C';
        }
        else{
            
             grade = 'D';
            System.debug(student_name+ ' is failled ');
        }
        
        return grade;
    }
    
    // output  --> print the values --> coming from data members 
     public void getValues (){
        // statements --> perform the task
        System.debug('student name is :'+student_name);
        System.debug('student gender is :'+gender);
        System.debug('student date of birth is :'+date_of_birth);
        System.debug('student class is :'+class_no);
        System.debug('student contact number is :'+contact_no);
    }

      // for static variable we should create static method
    public static void schooltime(){
        System.debug('School Time : '+school_time);
    } 
}
