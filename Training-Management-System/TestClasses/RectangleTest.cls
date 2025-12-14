@isTest //Test class /calling point
public class RectangleTest {
          // test class has methods like class
          // now define the test method
          // () this represents the method
          // test class execution start from main method()
    static testMethod void main(){
        //type of test method is static
        //keyword of testMethod is testMethod
        //return_type of testMethod is void
       // now create the object --> for calling the class -- > syntax --> className objName = new className();
                                       Rectangle rec1 = new Rectangle ();
        // new object is created named as rec1
        // constructor --> duty is loading the values into object
        // now call the methods from calling point --> we defined 2 methods in class (setValues ,getValues)
        // for calling the methods we have syntax --> objName.memMethod(arguments 1,arguments 2,..);
                                          rec1.setValues(25,15); //integer len,integer wide
                                          rec1.getValues();
        //data is always --> private (abstraction level)
        //instructions is always --> public (abstraction level)
        // create another object --> syntax --> className objName = new className();
                                      Rectangle rec2 = new Rectangle();
        // now call the 2 methods from calling point --> objName.memMethod(argument 1,argument 2,...);
                                      rec2.setValues(45,25);
                                      rec2.getValues();
        
                                   Rectangle rec4 = new Rectangle();
                                      rec4.setValues(49,79);
                                      rec4.getValues();
        
                                 Rectangle rec5 = new Rectangle(89 ,99);
                                    rec5.getValues();
         //create new object for action method
                                    Rectangle rec6 = new Rectangle();
                                      rec6.setValues(50,40);
                                   Integer area = rec6.calArea();
                                   System.debug('Area of Rectangle : '+area);
                                      rec6.getValues();
                                  // now calculate volume with the area return value
                                   Integer height = 20;
                                  System.debug('Volume of the rectangle : '+area * height);
                                  Integer perimeter = rec6.calPerimeter();
                                  System.debug('Perimeter of the rectangle : '+perimeter);
                                  Double Diagonal = rec6.calDiagonal();
                                  System.debug('Diagonal of the rectangle :'+Diagonal);
                                  rec6.checkIsSquare();
                               
        
        
    }
}
