public class AccountTriggerHandler {
    public static void beforeinsert(list<Account> accounts){
      //Write A Trigger On Account Object 
      //Update the account rating to hot if the industry is banking
        
        for(Account newAc : accounts){
            if(newAc.Industry == 'Banking'){ 
               newAc.Rating = 'Hot'; 
            }
        } 
    }
    public static void validationError(list<Account> accList){
        //Task --> Write A Trigger On Account Object
        //Account industry,Fax,Phone is must
        for(Account newAccount : accList){
            if(newAccount.Industry == NULL || newAccount.Industry== ''){
                newAccount.addError('Enter Industry');
            }
            if(newAccount.Fax == NULL || newAccount.Fax ==''){
                newAccount.addError('Enter Fax');
            }
            if(newAccount.Phone == NULL || newAccount.Phone ==''){
                newAccount.addError('Enter Phone');
            }
           
        }
    }
 }
