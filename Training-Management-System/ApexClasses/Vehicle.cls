public class Vehicle {
    //vehicle --> class Name
    //datamembers/properties/data
    //syntax for datamembers --> datatype name 
    //abstraction level of data members is private 
    //data always hidden
         private string Vehicleid;
         private string VehicleNum;
         private string vehiclebrand;
         private decimal mileage;
         private String fuel;
         private string model;
    // define methods --> we have definition point 
    /* syntax for definition point -->public returntype methodName(datatype name1,datatype name 2..){
        statements --> perform the task 
}*/  // instructions always public 
    // methods 4 types 
    // create --> here we can give dummy values
    // constructor --> loading intial values into constructor 
    // in default constructor we can load dummy values
    public Vehicle(){
        vehicleid = 'V-000';
     vehicleNum = '0';
      vehiclebrand = 'No name';
        mileage = 0.00;
      fuel = 'no fuel';
      model = '0000';
    } 
    // input  --> loading values into datamembers
  public void setValues(string id,string No,string brand,decimal mileag, string oil,string mod){
        Vehicleid =id;
       VehicleNum = No;
       vehiclebrand = brand;
       mileage = mileag;
       fuel = oil;
       model = mod;
    } 
    
    // action/processing --> what we can do with vehicle 
    
    // output 
    public void getValues(){
        System.debug('Vehicle id :'+Vehicleid);
        System.debug('Vehicle Number :'+VehicleNum);
        System.debug('Vehicle Brand :'+vehiclebrand);
        System.debug('Vehicle Fuel :'+fuel);
        System.debug('Vehicle Model :'+model);
        System.debug('Mileage is :'+mileage);
    }   
    
    
    
}
