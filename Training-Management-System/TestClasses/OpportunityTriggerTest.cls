@isTest
public class OppTriggerTest {

    @istest static void testOppbeforeinsert(){
        Opportunity opportunity1 = new Opportunity();
        opportunity1.name ='Ramya Pickles business deal';
        opportunity1.StageName = 'Qualification';
        opportunity1.CloseDate = Date.today();
        opportunity1.Amount =10000;
        insert opportunity1;
        //fetch thus dummy record
     Opportunity opp  = [select id,name,StageName,CloseDate from Opportunity where id = :opportunity1.id];
        System.assertEquals('Prospecting',opp.StageName);
        System.assertEquals(Date.today().addDays(15),opp.CloseDate);
        
    } 
    @isTest static void testoppbeforeupdate(){
            Opportunity opportunity2 = new Opportunity();
        
                opportunity2.name = 'Malik Bhai Business deal';
                opportunity2.StageName = 'Closed Won';
              opportunity2.CloseDate = Date.today().addDays(20);
        opportunity2.amount =10000;
              insert opportunity2;
            Opportunity opps =  [select id,name,stagename,CloseDate from opportunity where  id = :opportunity2.id];
                opportunity2.CloseDate = Date.today().addDays(100);
                try{
                    update opportunity2;
                    System.assert(false,'expected error but inserted successfully');
                } catch(DmlException e){
                    System.assert(e.getMessage().contains('Close Date cannot be more than 90 days from today'),'Error message should match expected text');
                }
            
             
        }
    @istest static void testOppprobability(){
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Name = 'Raghu business';
        opportunity1.Amount = 9000;
        opportunity1.StageName = 'Qualification';
        opportunity1.CloseDate = Date.today().adddays(12);
        insert opportunity1;
      Opportunity opp = [select id,name,Amount,StageName,CloseDate from Opportunity where id =:opportunity1.Id];
        opp.amount = 0;
        
        try{
        update opp;
        System.assert(false,'Expected Error but Updated successfully');
        }catch(dmlException e){
            System.assert(e.getMessage().contains('Amount must be greater than zero'));
        }
        
        Opportunity opportunity = new Opportunity();
        opportunity.name = 'Vijay Business';
        opportunity.Stagename = 'Closed Won';
        opportunity.CloseDate = Date.today().adddays(10);
        opportunity.amount =100000;
        insert opportunity;
     Opportunity opp1  = [select id,Name,StageName,Probability from Opportunity where id =:opportunity.Id];
        System.assertEquals(100,opp1.Probability);
        
        Opportunity opportunity2 = new Opportunity();
        opportunity2.name = 'Ajay Business';
        opportunity2.Stagename = 'Closed Lost';
        opportunity2.CloseDate = Date.today().adddays(14);
        opportunity2.amount = 10000;
        
        insert opportunity2;
     Opportunity opp2  = [select id,Name,StageName,Probability from Opportunity where id =:opportunity2.Id];
        System.assertEquals(0,opp2.Probability);
        
    }
   @istest static void testOppdeal(){
        Opportunity opportunity = new Opportunity();
       opportunity.Name = 'Shailaja business';
       opportunity.Amount = 900000;
       opportunity.StageName = 'Qualification';
       opportunity.CloseDate = Date.today().adddays(14);
       insert opportunity;
     Opportunity opp = [select id,Name,Amount,Opportunity_Type__c from Opportunity where id = :opportunity.Id];
       System.assertEquals('Big Deal',opp.Opportunity_Type__c);
       
       
       Opportunity opportunity1 = new Opportunity();
       opportunity1.Name = 'Prabhas business';
       opportunity1.Amount = 400000;
       opportunity1.StageName = 'Qualification';
       opportunity1.CloseDate = Date.today().adddays(10);
       insert opportunity1;
     Opportunity opp1 = [select id,Name,Amount,Opportunity_Type__c from Opportunity where id = :opportunity1.Id];
       System.assertEquals('Medium Deal',opp1.Opportunity_Type__c);
       
       Opportunity opportunity2 = new Opportunity();
       opportunity2.Name = 'NTR business';
       opportunity2.Amount = 40000;
       opportunity2.StageName = 'Qualification';
       opportunity2.CloseDate = Date.today().adddays(10);
       insert opportunity2;
     Opportunity opp2 = [select id,Name,Amount,Opportunity_Type__c from Opportunity where id = :opportunity2.Id];
       System.assertEquals('Small Deal',opp2.Opportunity_Type__c);
       
       Opportunity opportunity4 = new Opportunity();
       opportunity4.Name = 'Mahesh business';
       opportunity4.Amount = 400000;
       opportunity4.StageName = 'Qualification';
       opportunity4.CloseDate = Date.today().adddays(10);
       insert opportunity4;
     Opportunity opp4 = [select id,Name,CloseDate from Opportunity where id = :opportunity4.Id];
      opp4.CloseDate =  Date.today().adddays(-1);
       
       try{
           update opp4;
       System.assert(false,'Expected error but updated successfully');
       }catch(dmlException e){
           System.assert(e.getMessage().contains('Close Date cannot be in the past'));
       }
       
       
       
       
    }
}
