@isTest //test class /calling point
public class MobileTest {
    static testMethod void main(){
        
            // create new object --> className objName = new className();
                                    Mobile mob1 = new Mobile();
        // calling methods --> objName.memMethod(argument1,argument 2,...)
                          mob1.setValues('120gb','16mp','samsung',20000);
                          mob1.getValues();
        //data is always private
        //instructions is always public
        //create new object for action method
                          Mobile mob2 = new Mobile();
                          mob2.setValues('160gb','24mp','VIVO',20000);
                          Integer NetPrice = mob2.calNetPrice();
                          mob2.getValues();
        //create new object 
                 Mobile mob4 = new Mobile() ;
                 mob4.setValues('200gb','40mp','Motorola',40000);
                 Integer finalPrice = mob4.discountRules();
                 mob4.getValues();
                 
        // create another object
           
                 Mobile mob5 = new Mobile() ;
                 mob5.setValues('400gb','60mp','iphone',100000);
                 mob5.getValues();
                 Integer finalCost = mob5.emiRules(24); 
                 
                            Mobile mob6 = new Mobile() ;
                 mob6.setValues('400gb','60mp','iphone',100000);
                 mob6.getValues();
                 Integer warranty = mob6.calWarranty(); 
        
              Mobile mob7 = new Mobile() ;
                 mob7.setValues('40gb','20mp','Apple',90000);
                 mob7.getValues();
             Integer finalCost1 = mob7.calExchangeOffer(8);
                 
                     Mobile mob8 = new Mobile() ;
                 mob8.setValues('41gb','21mp','Nokia',40000);
                 mob8.getValues();
             Integer deliveryCharges = mob8.calDeliveryCharges();
        
             Mobile mob9 = new Mobile() ;
                 mob9.setValues('59gb','29mp','LG',40000);
                 mob9.getValues();
             Integer totalfinalAmount = mob9.bulkOrder(4);
        
    }
    @isTest static void testnetprice(){
        Mobile mob1 = new Mobile();
        mob1.setValues('41gb','21mp','Nokia',5000);
        Integer NetPrice = mob1.calNetPrice();
        System.assertEquals(5000,NetPrice);
        
        Mobile mob2 = new Mobile();
        mob2.setValues('40gb','20mp','Nokia 2',20000);
        Integer NetPrice1 = mob2.calNetPrice();
        System.assertEquals(21000,NetPrice1);
        
        Mobile mob4 = new Mobile();
        mob4.setValues('40gb','20mp','Samsung',40000);
        Integer NetPrice2 = mob4.calNetPrice();
        System.assertEquals(44800,NetPrice2);
        
        Mobile mob5 = new Mobile();
        mob5.setValues('40gb','20mp','Rolex',80000);
        Integer NetPrice4 = mob5.calNetPrice();
        System.assertEquals(94400,NetPrice4);
        
        Mobile mob6 = new Mobile();
        mob6.setValues('60gb','40mp','Rolex 2',100000);
        Integer NetPrice5 = mob6.calNetPrice();
        System.assertEquals(128000,NetPrice5);
        
        
        
    }
    
   @isTest static void testdiscountrules(){
        Mobile mob1 = new Mobile();
        mob1.setValues('120gb', '16mp', 'LG', 10000);
       Integer finalCost = mob1.discountRules();
       System.assertEquals(10000,finalCost);
       
         Mobile mob2 = new Mobile();
        mob2.setValues('120gb', '8mp', 'Vivo', 20000);
       Integer finalCost1 = mob2.discountRules();
       System.assertEquals(19000,finalCost1);
       
       Mobile mob4 = new Mobile();
        mob4.setValues('60gb', '8mp', 'Vivo T2X',40000);
       Integer finalCost2 = mob4.discountRules();
       System.assertEquals(36000,finalCost2);
       
       Mobile mob5 = new Mobile();
        mob5.setValues('60gb', '8mp', 'Vivo 5G',60000);
       Integer finalCost4 = mob5.discountRules();
       System.assertEquals(52800,finalCost4);
       
       Mobile mob6 = new Mobile();
        mob6.setValues('60gb', '16mp', 'Vivo 4G',80000);
       Integer finalCost5 = mob6.discountRules();
       System.assertEquals(68000,finalCost5);
       
        
    }
    
   @isTest static void testemirules(){
        Mobile mob1 = new Mobile();
        mob1.setValues('60gb', '16mp', 'Vivo 4G',10000);
      Integer finalCost = mob1.emiRules(12);
       System.assertEquals(10000,finalcost);
       
       Mobile mob2 = new Mobile();
        mob2.setValues('60gb', '16mp', 'Real Me',25000);
      Integer finalCost2 = mob2.emiRules(12);
       System.assertEquals(26250,finalcost2);
       
       Mobile mob4 = new Mobile();
        mob4.setValues('60gb', '16mp', 'Real Me 5G',50000);
      Integer finalCost4 = mob4.emiRules(12);
       System.assertEquals(54000,finalcost4);
       
       
       Mobile mob5 = new Mobile();
        mob5.setValues('60gb', '7mp', 'Real Me 4G',80000);
      Integer finalCost5 = mob5.emiRules(12);
       System.assertEquals(88000,finalcost5);
       
       Mobile mob6 = new Mobile();
        mob6.setValues('60gb', '10mp', 'Real Me 6G',100000);
      Integer finalCost6 = mob6.emiRules(12);
       System.assertEquals(112000,finalcost6);
   }
       
      @isTest static void testWarranty(){
           
           Mobile mob1 = new Mobile();
          mob1.setValues('80gb', '12mp', 'Oppo 6G',100000);
         Integer Warranty = mob1.calWarranty();
          System.assertEquals(2,Warranty); 
       
          
          Mobile mob2 = new Mobile();
          mob2.setValues('90gb', '16mp', 'Oppo 2X 5G',10000);
         Integer Warranty2 = mob2.calWarranty();
          System.assertEquals(1,Warranty2); 
    }
    
    @isTest static void testcalExchangeOffer(){
        Mobile mob1 = new Mobile();
        mob1.setValues('120gb', '18mp', 'Oppo 2T 5G',10000);
        Integer finalCost = mob1.calExchangeOffer(1);
        System.assertEquals(6000,finalCost);
        
         Mobile mob2 = new Mobile();
        mob2.setValues('140gb', '20mp', 'Vivo',10000);
        Integer finalCost1 = mob1.calExchangeOffer(2);
        System.assertEquals(7500,finalCost1); 
        
        Mobile mob4 = new Mobile();
        mob4.setValues('140gb', '20mp', 'Vivo',10000);
        Integer finalCost4 = mob4.calExchangeOffer(4);
        System.assertEquals(9000,finalCost4); 
        
        
    }
    @isTest static void testdeliverycharges(){
        Mobile mob1 = new Mobile();
        mob1.setValues('140gb', '20mp', 'Vivo 1919',25000);
        Integer deliveryCharges = mob1.calDeliveryCharges();
        System.assertEquals(0,deliveryCharges);
        
        Mobile mob2 = new Mobile();
        mob2.setValues('140gb', '20mp', 'Vivo T2X',20000);
        Integer deliveryCharges1 = mob2.calDeliveryCharges();
        System.assertEquals(500,deliveryCharges1);
        
    }
    
  @isTest static void testbulkOrder(){
        Mobile mob1 = new Mobile();
        mob1.setValues('140gb', '20mp', 'LG',20000);
       Integer totalfinalCost = mob1.bulkOrder(5);
       System.assertEquals(90000,totalfinalCost);
      
      Mobile mob2 = new Mobile();
        mob2.setValues('140gb', '20mp', 'Samsung',20000);
       Integer totalfinalCost2 = mob2.bulkOrder(2);
       System.assertEquals(38000,totalfinalCost2);
      
      Mobile mob4 = new Mobile();
        mob4.setValues('120gb', '20mp', 'Motorola',20000);
       Integer totalfinalCost4 = mob4.bulkOrder(1);
       System.assertEquals(20000,totalfinalCost4);

      
    }
    
    
}
