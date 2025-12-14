public class course {
   //public --> abstraction or access specifier
   //class --> iam writing a class
   //course --> className
   //class is the combination of data and abstraction (programming elements)
   //data/data members/properties --> (course_name , course_old_fee,course_new_fee,Availability)
      private   String course_name;
       private Decimal course_old_fee;
       private Decimal course_new_fee;
        private String  availability;
          private Integer Duration;
   // syntax for declared variables --> datatype name;
   // instructions/functions/methods/behaviours/member methods --> achieved by definition and calling point --> provides the service to data members
    /*syntax for definition --> return_type methodName (datatype name1, datatype name 2,...){
         -->statements --> perform the task 
                      }*/
    //instructions/methods/functions divided 4 parts
    //create --> loading the intial values into constructor
    //null --> dummy values --> meaningfull values --> 
    public Course (){
        course_name = 'no name';
        course_old_fee = 0;
        course_new_fee = 0;
        availability = 'no availability';
        Duration = 0;
        
    }
    // parametaraised constructor -->
    // null--> meaningfull values --> parameteraised constructor
    // constructor + setValues => parameteraised constructor
    public Course (String c_name ,Decimal old , Decimal new_fe,String avail, Integer timep){
        // statements --> perform the tasks
         course_name = c_name;
         course_old_fee = old;
         course_new_fee = new_fe;
         availability = avail;
         Duration = timep;
        
    }
    //input --> load the values into data members
 public void setValues (String c_name ,Decimal old , Decimal new_fe,String avail, Integer timep){
        // statements --> perform the tasks
         course_name = c_name;
         course_old_fee = old;
         course_new_fee = new_fe;
         availability = avail;
         Duration = timep;
        
    }
    //action/processing  -->
/* Course Discount Rules (Slabs)
If Fee ≤ 10,000 → 5% discount
If 10,001 – 25,000 → 10% discount
If 25,001 – 45,000 → 15% discount
If Fee > 45,000 → 20% discount */
    public Decimal DiscountRules(){
        Decimal discount;
        Decimal discountamount;
        Decimal newUpdatedfee;
        
        if(course_new_fee <= 10000){
             discount = 5;
        }
        
        else if(course_new_fee >= 10001 && course_new_fee <= 25000){
            discount = 10;
        }
        else if(course_new_fee >= 25001 && course_new_fee <= 45000){
            discount = 15;
        }
        else{
             discount = 25;
        }
        
        discountamount = (course_new_fee * discount)/100;
        newUpdatedfee = (course_new_fee - discountamount);
        return newUpdatedfee;
    }
    
    // extendDuration(extraWeeks) → for this we need --> course name,duration,fee,extra weeks
    public void extendDuration(Integer extraweeks){
        Duration+= extraweeks;
            System.debug(course_name+ ' is extended for :' +Duration+  ' Weeks ');
        
    }
    
    
    //output ---> print the values -->from data members
 public   void getValues (){
        // statements --> perform the tasks
        System.debug('course name :'+course_name);
        System.debug('course old fee :'+ course_old_fee);
        System.debug('course new fee :'+ course_new_fee);
        System.debug('course availability :'+availability);
        System.debug('course Duration :'+Duration);
        
    }
}
