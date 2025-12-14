@istest //calling point /test class
public class CarTest {

    public static testMethod void testCar1(){
        
        //create the object 
        //Syntax --> className obj = new className();
        //syntax for calling method --> obj.memMethod();
       Car car1 = new Car();
        car1.setValues('AP15AE2014','Hyundai creta',1500000,true,'black');
        car1.getValues(); 
        Decimal Mileage = car1.calMileage(100.00 ,5.0); 
        Decimal finalAmount= car1.calDiscount();
        Car.company();
        System.debug('Mileage: ' +mileage);
        System.debug('Final Amount: ' + finalAmount);
        System.assertEquals(20,Mileage);
        System.assertEquals(1350000,finalAmount);
        
        
        
    } 
    @istest static void testCar2(){
        
        Car car2 = new Car();
        car2.setValues('AP15AE2015','Hyundai 2',400000,true,'White');
        car2.getValues();
       Decimal Mileage = car2.calMileage(50.00,5.0);
        Decimal finalAmount = car2.calDiscount();
        car.company();
        System.debug('Mileage: ' +mileage);
        System.debug('Final Amount: ' + finalAmount);
        System.assertEquals(10.0,Mileage);
        System.assertEquals(400000,finalAmount);
        
        
    }
    @isTest static void testcar3(){
        
        Car car3 = new Car();
        car3.setValues('AP15AE2017','Hyundai 3 ',600000,true,'Black');
        car3.getValues();
       Decimal Mileage= car3.calMileage(80.0, 8.0);
        Decimal finalAmount = car3.calDiscount();
        System.debug('Mileage: ' +mileage);
        System.debug('Final Amount: ' + finalAmount);
         System.assertEquals(10.0,Mileage);
        System.assertEquals(570000,finalAmount);
        
        
        
        
    }
    
    @isTest static void testcar4(){
        
        Car car4 = new Car();
        car4.setValues('AP15AE2011','Hyundai 4 ',2500000,true,'Black');
        car4.getValues();
       Decimal Mileage = car4.calMileage(100.0, 10.0);
       Decimal finalAmount = car4.calDiscount();
        System.debug('Mileage: ' +mileage);
        System.debug('Final Amount: ' + finalAmount);
         System.assertEquals(10.0,Mileage);
        System.assertEquals(2125000,finalAmount);

        
        
    }
    
}
