public class FutureMethodsClass {
 public void mixedDMLException(){
        // deactivate a user // setup object
     list<User> activeUser  = [select id,firstname,lastname,username,isActive 
from user where username = 'hklaasen@agentforce.com' and isActive = true LIMit 1];
        if(!activeUser.isEmpty()){
            activeUser[0].IsActive = false;
            update activeUser;
        }
           insertAcc();
    }
    @future
    public static void insertAcc(){
        //insert account // non setup object
      Account acc = new Account();
        acc.name = 'ICICII Bank';
        acc.Rating ='Warm';
        acc.Industry ='Banking';
        acc.Fax ='560';
        acc.Phone = '98080';
        insert acc;
    }
    
    
    }
