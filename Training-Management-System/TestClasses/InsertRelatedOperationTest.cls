@isTest
public class InsertRelatedOperationTest {
    @istest static void testinsert(){
    InsertRelatedOperation.insertingrelatedrecords();
  Integer accountsCount = [select Count() from Account];
    System.assertEquals(1,accountsCount);
  Account ac = [select id,Name from Account];
    System.assertEquals('TV5 Media House',ac.name);
        
 Integer contactsCount = [select count() from  Contact];
   System.assertEquals(1,contactsCount);
 Contact con =  [select id,firstname,lastname,AccountId from Contact where AccountId = :ac.id];
        System.assertEquals(ac.id,con.AccountId);
        System.assertEquals('Murthy',con.FirstName);
        System.assertEquals('kumar',con.LastName);
        
        integer opportunitiesCount = [select count() from Opportunity];
        System.assertEquals(1,opportunitiesCount);
       Opportunity opp = [select id,Name,AccountId from Opportunity where AccountId = :ac.id];
        System.assertEquals(ac.id ,opp.AccountId);
        System.assertEquals('TV5 Business Deal',opp.name);
        
    Integer casesCount  =  [select count() from Case];
        System.assertEquals(1,casesCount);
Case case1  = [select id,AccountId,ContactId from Case Where AccountId = :ac.Id and ContactId = :con.Id];
        System.assertEquals(ac.id,case1.AccountId);
        System.assertEquals(con.id,case1.ContactId);
        
        
    
    }   
}
