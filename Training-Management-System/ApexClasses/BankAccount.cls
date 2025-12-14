public class BankAccount{ // business class
    
    //data/data members/properties ==> (account_number,account_name,bank_name,account_balence)
    //syntax --> datatype name;
    long account_number;
    String account_name;
    String bank_name;
    Integer account_balence;
    //properties/methods/functions ==> for defining methods we definition point
    /*syntax --> returntype methodName (datatype name1,datatype name2,..){
     --> statements --> perform the task
    }*/
    //methods divided into 4 parts
    //create
     // for avoiding null values ==> we store some dummy values --> by using default constructor
    public BankAccount(){
        account_number = 0;
        account_name ='no name';
        bank_name ='no name';
        account_balence =0;
    }
     
    //input
    public void setValues(long ac_num ,String ac_name,String bank ,Integer ac_balence){
        account_number = ac_num;
        account_name = ac_name;
        bank_name = bank;
        account_balence = ac_balence;
    } 
    //action/processing --> what we can do with BankAccount --> transactions --> deposit , withdrawl
    public  void  deposit(Integer depositedamount){
        
        if(depositedamount <=0){
            System.debug('invalid transaction');
        }
        else{
            account_balence = depositedamount+account_balence;
            System.debug('Your New Account Balence : '+account_balence);
        }                                                                     //--> what required for deposit --> account number , bank name , account name , amount
                                                                               // --> // here expect amount remaining all in datamembers      
    }                                                               
       // now withdrawl action method                                     //--> what we require for withdrawl --> account number , account name , bank name ,amount
    public void withdrawl(Integer amount){ 
        if(amount<=0){
            System.debug('invalid transaction');
        }  
        else If(amount > account_balence){
            System.debug('insuffient funds');
            
        }
        else{ 
             account_balence = account_balence - amount;
            System.debug('Your new Account Balence :'+account_balence);
        }          
                                                                                                      
    } 
    
    
    
    //output
   public void getValues(){
        System.debug('account number :'+account_number);
        System.debug('account name :'+account_name);
        System.debug('Bank name :'+bank_name);
        System.debug('account balence :'+account_balence);
    }
      
}
