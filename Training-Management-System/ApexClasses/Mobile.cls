public class Mobile { //business class
    //datamembers/data/properties -- storage ,camara,company,cost
    //syntax --> datatype name
 private    String storage;
 private    String camara;
 private    String company;
 private    Integer cost;
    //instructions/methods/funcions/membermethods/behaviours
    /*syntax --> returntype methodName(datatype name1,datatype name2 ,..){
            statements --> perform the task
}*/
    //methods/instructions divided into 4 types
    //create --> load intial values --> constructor
    //for avoiding null values we define default constructor
    //null--> dummy values --> meaningfull values 
    public Mobile (){
        storage ='0 gb';
        camara ='0 mp';
        company = 'no company';
        cost =0;
    }
    //input
 public   void setValues(String store, String cam,String comp,Integer price){
         storage =store;
        camara =cam;
        company = comp;
        cost = price;
        
    }
    //action/Processing --> for calculation of net price --> we need price,gst,mobile
    //we have price , we have mobile we dont have gst
   /* Cost Range (₹)	GST Rate (%)
0 – 10,000	0%
10,001 – 25,000	5%
25,001 – 40,000	12%
40,001 – 85,000	18%
85,001 and above	28% */
     
    public Integer calNetPrice(){
        
        Integer GST;
        Integer GSTAmount;
        Integer NetPrice;
        
        if(cost>=0 && cost <=10000){
            GST = 0;
        }
        
        else if(cost >= 10001 && cost <= 25000){
            GST = 5;
        }
        else if(cost >= 25001 && cost <= 40000){
             GST = 12;
        }
        else if(cost >= 40001 && cost <=85000){
              GST = 18;
        }
        else{
              GST = 28;
        }
        
        GSTAmount = (cost * GST)/100;
        NetPrice = GSTAmount + cost;
        System.debug(company+ ' GST Amount : ' +GSTAmount);
        System.debug(company+ ' Net Price : ' +NetPrice);
        return NetPrice;
    } 
       /*Discount Rules Based on Cost
Cost Range (₹)	Discount (%)
0 – 15,000	0%
15,001 – 25,000	5%
25,001 – 40,000	10%
40,001 – 60,000	12%
60,001 and above	15% */
    public Integer discountRules(){
        Integer discountAmount;
        Integer discountPercentage;
        Integer finalCost;
        
        if(cost <= 15000){
            discountPercentage = 0;
        }
        else if(cost >= 15001 && cost <=25000){
            discountPercentage = 5;
        }
        else if(cost >= 25001 && cost <=40000){
            discountPercentage = 10;
        }
        else if(cost >= 40001 && cost <= 60000){
            discountPercentage = 12;
        }
        else{
            discountPercentage = 15;
        }
        discountAmount = (cost *discountPercentage)/100;
        finalCost = cost - discountAmount;
        System.debug(company+ ' Got discount by : '+discountAmount);
        System.debug(company+ ' Final Price : ' +finalCost);
         return finalCost;
    }
    /* 📌 EMI Rules
Cost Range (₹)	Interest Rate (%)	Max EMI Duration (Months)
0 – 20,000	0% (No Cost EMI)	6 months
20,001 – 35,000	5%	9 months
35,001 – 50,000	8%	12 months
50,001 – 80,000	10%	18 months
80,001 and above	12%	24 months */
    
    public Integer emiRules(Integer noOfMonths){
           Integer interestAmount;
           Integer finalCost;
           Integer emiPerMonth;
           Integer interestRate;
           
        
        if(cost <= 20000){
            interestRate = 0;
        }
        else if(cost >= 20001 && cost<= 35000){
            interestRate = 5;
        }
        else if(cost >= 35001 && cost<= 50000){
            interestRate = 8;
        }
        else if(cost >= 50001 && cost <= 80000){
            interestRate =10;
        }
        else{
            interestRate =12;
        }
        
        interestAmount = (cost * interestRate)/100;
        finalCost = (interestAmount + cost);
        emiPerMonth = finalCost/noOfMonths;
        
        System.debug(company+ ' Interest Amount : ' +interestAmount);
        System.debug(company+ ' final Price : '+finalCost);
        System.debug(company+ ' EMI Paid By Per Month : '+emiPerMonth);
        return finalCost;
    } 
/*
Warranty Calculation
Rule: Every mobile has 1-year default warranty.
If cost > ₹30,000 → extend warranty by +1 year.
Method: calculateWarrantyPeriod().*/
    
    public Integer calWarranty(){
        Integer warranty =1 ; //default value 
        if(cost >30000){
            warranty = warranty+1;
         System.debug(company+ ' warranty is extended.Total warranty : ' +warranty+ ' Years ');
        }
        else{
            System.debug(company+ ' warranty : '+warranty+ ' year ');
        }
        
           return warranty;
    } 
    
    /* Exchange Offer Price
Rule: If customer gives old mobile, reduce price.
Example:
Old phone age ≤ 1 year → 40% exchange value.
Age 2 years → 25%.
Age 3+ years → 10%. */ 
    // what we need --> cost , old phone age ,
    public Integer calExchangeOffer(Integer OldMobileAge){
        Integer deductedCost;
        Integer finalCost;
        
        if(oldMobileAge <=1){
             deductedCost = (cost*40)/100;   //40% of old value 
            finalCost = cost - deductedCost;    
            
        }
        else if(oldMobileAge <=2){
             deductedCost = (cost *25)/100;
            finalCost = cost - deductedCost;
        }
        else{
            deductedCost = (cost *10)/100;
            finalCost = cost - deductedCost;
            
        }
        System.debug(company+ ' deducted Amount : ' +deductedCost);
        System.debug(company+ ' final Amount : ' +finalCost);
           return finalCost;
    }
        
        //Delivery Charges
        /*Rule:
Cost ≥ 25,000 → Free delivery.
Otherwise → ₹500 charge. */
    public Integer calDeliveryCharges(){
           Integer deliveryCharges;
        
        if(cost >= 25000){
            deliveryCharges =0;
        }
        else{
            deliveryCharges = 500;
        }
        
        System.debug(company+ ' delivery charges = '+deliveryCharges);
               
        return deliveryCharges;
    }
    
   /* Bulk Order Discount (if customer buys more than 1 mobile)
Rule:
Qty ≥ 2 → 5% discount.
Qty ≥ 5 → 10% discount. */
    public Integer bulkOrder(Integer mobileQuantity){
        Integer discount;
        Integer discountAmount;
        Integer finalAmount;
       Integer totalfinalAmount;
        
        if(mobileQuantity >= 5){
            discount = 10;
        }
        else if(mobileQuantity >= 2){
            discount =5;
        }
        else{
            discount =0;
        }
        discountAmount = (cost * discount)/100;
        finalAmount = cost - discountAmount;
        totalfinalAmount = finalAmount * mobileQuantity;
        System.debug(company+ ' discount Amount : '+discountAmount);
        System.debug(company+ ' Final Amount :' +finalAmount);
        System.debug(company+ ' Total Final Amount :' +totalfinalAmount);
           return totalfinalAmount;
    } 
        
    //output
 public void getValues(){
        System.debug('mobile storage :'+storage);
        System.debug('mobile camara :'+camara);
        System.debug('mobile company :'+company);
        System.debug('mobile cost :'+cost);
    }

}
