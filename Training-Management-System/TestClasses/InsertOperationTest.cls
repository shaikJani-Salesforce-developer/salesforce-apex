@isTest
public class InsertOperationTest {

   @istest static void testInsert(){
        
        InsertOperation insertAc = new InsertOperation();
        insertAc.insertstandardrecord();
       Integer accountsCount = [Select Count() from Account];
       System.assertEquals(5,accountsCount);
          // now fetch records which i inserted just now
      list<Account> accounts  = [select id,Name from Account Where Name IN('Genetic info solutionss', 
            'Capgemini', 
            'Rise College of Engineering & Technology', 
            'DMart Store', 
            'Aparna Cyber Cafe')];
             
       System.assertEquals('Genetic info solutionss',accounts[0].name);
       System.assertEquals('Capgemini',accounts[1].name);
       System.assertEquals('Rise College of Engineering & Technology',accounts[2].name);
       System.assertEquals('DMart Store',accounts[3].name);
       System.assertEquals('Aparna Cyber Cafe',accounts[4].name);
       
    }
    
   @istest static void testinsertcustom(){
        InsertOperation.insertcustomrecord();
      Integer ProjectsCount = [Select Count() from Projects__c];
       System.assertEquals(5,ProjectsCount);
       //now fetch the records just i created
      list<Projects__c> projects = [select id,Name from Projects__c];
       System.assertEquals('Project OG',projects[0].name);
       System.assertEquals('Project Lenin',projects[1].name);
       System.assertEquals('Project Singam',projects[2].name);
       System.assertEquals('Project dhruva',projects[3].name);
       System.assertEquals('Project Chola',projects[4].name);
       
        
    }
}
