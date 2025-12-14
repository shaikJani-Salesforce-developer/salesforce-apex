public class Pen {
   //public is called abstraction or access specifier
   //class --> we are writing a class
   //pen --> className
   //class is the combination of data and instructions (programming elements)
   //data/data members/properties (colour,cost,model,ink)  
   //syntax ==> datatype name; 
   private   string colour;
   private   integer cost;
   private   string model;
   private   string ink;
   //instructions/methods/functions/behaviours/member methods ==> they will provide service to data members
   //data will be coming from calling point --> definition point
   /*
public return_type methodName (datatype name1,datatype name2,...){
          ==> statements --> perform the tasks
}
  */
    // 4 parts 
    // create --> loading the initial values --> constructor
    // null -->dummy values --> meaningfull --> default constructor
    //syntax for default constructor 
    public Pen(){
       // statements -->perform task
       colour = 'no colour';
        cost=0;
        model ='no name';
        ink = 'no ink';
        
    }
        
    // parameteraised constructor 
    // null --> meaningfull values 
    // syntax
      public Pen (String col,Integer price ,String mod ,String ii){
        //statements ==> perform the task
        // assignment operators
        colour = col;
        cost = price ;
        model = mod;
        ink=ii;
      
  
    }
    // input --> duty is to load the values in the data members
   public void setValues (string col,integer price ,string mod ,string ii){
        //statements ==> perform the task
        // assignment operators
        colour = col;
        cost = price ;
        model = mod;
        ink=ii;
      
  
    }
    // action/processing
    // output --> print the values --> coming from data members
 public   void getValues (){
        //statements => perform the task --> print the values 
        system.debug('colour of the pen ='+colour);
        system.debug('cost of the pen ='+cost);
        system.debug ('model of the pen ='+model);
        system.debug ('ink of the pen = '+ink);
       
    }
        
    
 
}
