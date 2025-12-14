public class Rectangle { //business class
    //public --> access specifier
    //class --> defining the class
    //rectangle --> class name 
    //class consist of 2 programming elements (data and instructions) 
    // data/data members/properties --> synatx --> datatype name --> length ,width
          private  Integer length;
          private  Integer width;
    // instructions/methods/functions/member methods/behaviours ==> provide the service to data members
    // for achieving the instructions we have definition point and calling point
    /*syntax for definition point -->public return_type methodName (datatype name1,datatype name 2,..){
    // statements --> perform the task
  }*/
     //instructions/methods divided into 4 tpes 
     //create --. loading the initial values --> constructor
     //null --> dummy values --> meaningfull values --> default constructor
      //syntax
    public Rectangle (){
          length = 0;
           width = 0;
    }
     // parameteraised instructor
     // null --> ,meaningfull values --> parametaraised constructor 
     // constructor + setValues --> parametaraised constructor
      public Rectangle (Integer len,Integer wide){
        //statements --> perform the task
        length = len;
        width = wide;
    }
     //input --> loading the values into datamembers
  public void setValues (Integer len,Integer wide){
        //statements --> perform the task
        length = len;
        width = wide;
    }
     //action/processing --> what we do with rectangle --> are we can Find
     //for calculation of area --> we need length , width --> both are in datamembers
    public Integer calArea(){
          Integer area;
        area = length * width;
        return area;
    }
    
    // now find perimeter --> formula --> 2(legth * width)
    public Integer calPerimeter(){
        Integer perimeter;
        perimeter = 2*(length + width);
        return perimeter;
    }
// find diagonal --> formula --> square root of Length * Length + width * width
// how to reprsent square root in apex --> Math.sqrt()
    public Double calDiagonal(){
          Double Diagonal; 
        Diagonal = Math.sqrt(length * Length) + (width * width);
        return Diagonal;
    }
    //Is Square check (special type of rectangle)
    public void checkIsSquare(){
        if(length == width){
            System.debug('its a square');
        }
        else{
            System.debug('its a rectangle');
        }
    }
        
     //output --> print the values from data members
 public void getValues (){
      System.debug('length is :'+length);
      System.debug('width is :'+width);
        
    }
     
}
