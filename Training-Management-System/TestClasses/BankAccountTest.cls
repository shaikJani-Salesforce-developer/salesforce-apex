@isTest // calling point /test class
public class BankaccountTest {
   public static testMethod void main(){
       // create object ==> calling the class ==> syntax --> className objName = new className();
                   BankAccount Ba1 = new BankAccount();
       // calling 2 methods from calling point --> syntax  --> objName.Setvalues(datatype name 1,datatype name2,..);
                    Ba1.getValues() ;                                //long ac_num ,string ac_name,string bank ,integer ac_balence
                    Ba1.setValues (41215678967L,'ram','sbi',40000);
                    Ba1.getValues();
       // create new object 
               BankAccount Ba2 = new BankAccount();
                     Ba2.setValues(245678976541L,'raheem','icici',50000);
                      Ba2.getValues();
       // create new object for action methods
                     BankAccount Ba4 = new BankAccount();
                     Ba4.setValues (445776975542L,'Mastan','Bharat',50000);
                     Ba4.getValues();
                     Ba4.deposit(1);
       
                // create new object for action method
                BankAccount Ba5 =new BankAccount();
                  Ba5.setValues (445776974578L,'Manvith','Bharat',100000);
                  Ba5.getValues();     
                  Ba5.withdrawl(40);
                 
        
    }
     
    
  
}
