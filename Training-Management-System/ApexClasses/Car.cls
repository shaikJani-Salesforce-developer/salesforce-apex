public class Car {
     //className is Car
     //class consist of 2 programme elemts
     //1.Data members --> data is always hidden 
     //abstraction level is Private
     //2.Methods/Instructions --> instructions is always Public
     //abstraction level is Public
     //Syntax for Data members --> private Datatype name
     //Data Members/Properties
        static String company = 'Hyundai';
        Private String car_number;
        Private String car_model;
        Private Decimal car_price;
        Private Boolean air_bag;
        Private String car_colour;
         
        
    //Methovs/memberMethods/Functions
    //by achieving methods we have definition point 
    //syntax for definition point
    /*public return_type methodName(datatype name1,datatype name2,...){
      statements  --> perform the task
}   */
    // methods are 4 types
    // Create -> we can load dummy values --> 
    //we have default constructor
     //constructor dont have return type even void also
  public Car(){
       
       car_number = 'no number';
        car_model = '0';
        car_price =0;
        air_bag = false;
        car_colour ='no colour';
    }
    
    // Input --> we can load values into data members
   public void setValues(String num, String mod, Decimal cost, Boolean bag, String col){
       
       car_number = num;
       car_model = mod;
        car_price = cost;
        air_bag = bag;
       car_colour = col; 
        
        
    }
   
    // Action --> what can we do with car 
    // we can calculate mileage
    // formula for mileage 
    // Mileage = Distance Traveled/Fuel Consumed
    //we need distance travelled by car & consumed fuel in litres
   public Decimal calMileage(Decimal distance, Decimal fuel_in_litres){
        Decimal Mileage =  distance/fuel_in_litres;
         return Mileage;
        
    } 
    // we can give discounts for car
    // Cars below 10 Lakhs → 5% discount
    // Cars 10–20 Lakhs → 10% discount
    // Cars above 20 Lakhs → 15% discount
    // Cars below below 5 lakhs -- no disount
    
   public Decimal calDiscount(){
        
          Decimal discount;
        if(car_price < 500000){
              discount = 0;
        }
        else if(car_price >= 500000 && car_price < 1000000){
             discount = 5;
        }
        else if(car_price >= 1000000 && car_price <= 2000000){
             discount = 10;
        }
        else{
            discount = 15;
        }
           
         Decimal discountAmount;
          Decimal finalAmount;
        discountAmount = (car_price*discount)/100;
         finalAmount = (car_price - discountAmount);
         return finalAmount;
        
    } 
    
    // Output
  public void getValues(){
        System.debug('Car Number :'+car_number);
        System.debug('Car model :'+car_model);
        System.debug('Car Price :'+car_price);
        System.debug('Is There Air bag for Car :'+air_bag);
        system.debug('Car Colour :'+car_colour);
        
    }
    // we can write another output method for company
   public static void company(){
        System.debug('Car Company Name :'+company);
        
    }
       
    
    
    
}
