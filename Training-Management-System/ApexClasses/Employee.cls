public class Employee {
      // public --> abstraction or access specifier
      // class --> iam writing class
      // employee --> className
      // class --> class is combination of programming elements (data and instructions)
      // data/data members/properties -->(employee_name,salary,designation,Qualification,mobile)
      // syntax --> datatype name;
      public     string employee_name;
      public     Decimal salary;
      public      string designation;
      public    string Qualification;
      public    string mobile;
         
      
      // instructions/member methods/functions/methods/behaviours ==> instructions are achieved by definition and calling point
    /*synatx for definition --> return_type methodName (datatype name 1,datatype name 2,...){
                                 //statements --> perform the task}*/
                                
                                
                  
    //instructions/methods 4 types
    //create --> loading intial values --> constructor
    //null --> dummy -- meaningfull values --> default constructor
    // syntax -->
    public Employee (){
        //statements --> perform the task
        employee_name ='no name';
          salary =0;
        designation = 'no role';
        Qualification='no qualification';
        mobile ='no number';
    }
    // parametaraised constructor
    // null --> meaningfull values -->parametaraised constructor
    // constructor + setValues = parametaraised constructor
    // syntax-->
    public Employee (String emp_name, decimal sal,String role,String qualif ,String contact){
        //statements --> perform the task
                employee_name = emp_name;
                   salary = sal;
                  designation = role;
                  Qualification = qualif;
                    mobile = contact;
    }
    //input --> duty is to load values into data members
    //syntax
   public void setValues (string emp_name, decimal sal,string role,string qualif ,string contact){
        //statements --> perform the task
                employee_name = emp_name;
                   salary = sal;
                  designation = role;
                  Qualification = qualif;
                    mobile = contact;
    }
    
    
    //action/processing --> what we do for employees --> we can give bonus --> salary incriments 
    //for giving bonus --> we need salary,designation,name,qualification --> all we have in datamembers
    public Decimal updatedsalary(){
        
         Decimal percentagebonus;
         Decimal finalupdatedsalary;
         
        if (salary<=20000){
           percentagebonus=5;
        }
        else if(salary>20000 && salary <=50000){
           percentagebonus =10;
      }
    else if (salary>50000){
        percentagebonus = 15;
    }
    else{
        system.debug('invalid salary');
    }
        finalupdatedsalary = (salary*percentagebonus/100)+salary;
        return finalupdatedsalary;
    } 
    // pramote employee based on salary --> for promotion we require --> salary ,designation ,qualification
    public void   promoteEmployee(){
        // method cannot be declare as variable
        if (salary > 50000){
            designation = 'Senior' + designation;
        }
        else{
             designation = 'Junior' + designation;
        } 
        
    }
    
    /* Salary Hike Rules
1. Based on Experience (Years in industry)
≤ 2 years → Max 5%
3–5 years → Max 10%
6–10 years → Max 15%
> 10 years → Max 20% */ 
    // for defining salary hime --> we need salary ,employee name,exp,hike%
    public Decimal salaryhike(Integer experience){
        Decimal TotalNewSalary;
        Decimal Hikedamount;
        Decimal hikeinpercentage;
        
        if(experience <= 2){
            hikeinpercentage = 5;
        }
        else if(experience >=3 && experience <=5){
            hikeinpercentage = 10;
        }
        else if(experience >= 6 && experience <=10){
            hikeinpercentage = 15;
        }
        else{
            hikeinpercentage = 20;
        }
        
        Hikedamount = (salary * hikeinpercentage)/100;
        TotalNewSalary = Hikedamount + salary;
        salary = TotalNewSalary;
        System.debug(employee_name+ ' salary hiked by amount : ' +Hikedamount);
        System.debug(employee_name+ ' Total New Salary : ' +TotalNewSalary);
        return TotalNewSalary;
    }
    
   /*  2. Based on Performance Rating
Outstanding → +5% bonus hike
Good → +2% bonus hike
Average → No extra bonus
Poor → No hike (blocked) */ 
 //for this --> we need , salary ,performance,bonus 
    public Decimal calSalary(String Performance){
          Decimal Bonus;
          Decimal BonusAmount;
          Decimal NewSalary;
        if(Performance == 'Outstanding'){
             Bonus = 5;
        }
        else if(Performance == 'Good'){
            Bonus = 2;
        }
        else if(Performance == 'Average'){
            Bonus = 0;
        }
        else {
            System.debug(employee_name+ ' Performance is Poor hence he is Blocked ');
        }
      
         BonusAmount = (salary*Bonus)/100;     
         NewSalary = salary +BonusAmount;
         salary = NewSalary;
        System.debug(employee_name+ ' Got Bonus Amount By : '+BonusAmount);
        System.debug(employee_name+ ' Total New Salary : '+NewSalary);
           return NewSalary;
    }  
    //output   --> print the values --> coming from data members 
    //syntax
 public   void getValues () {
        //statements --> perform the task
        System.debug('employee name :'+employee_name);
        System.debug('employee salary :'+salary);
        System.debug('employee Role :'+designation);
        System.debug('employee Qualification :'+Qualification);
        System.debug('emplyee Mobile no :'+mobile);
    }                                               
}
