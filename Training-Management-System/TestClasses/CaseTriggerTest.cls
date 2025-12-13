@istest
public class CaseTriggerTest {
    
    @istest static void testCaseStatus(){
        Case case1 = new Case();
        case1.Status = 'Working';
        case1.Priority = 'High';
        case1.Origin = 'Web';
        insert case1;
        test.setCreatedDate(case1.id,System.now().addDays(-4));
        update case1;
        Case caseUp =[select id,CreatedDate,Status from Case where id =:case1.id];
        System.assertEquals('Escalated',caseUp.Status);
    }
    
    @istest static void testCaseOrigin(){
        Case case1 = new Case();
        case1.Status = 'Working';
        case1.Priority = 'Low';
        case1.Origin = 'Phone';
        insert case1;
        Case caseUp = [select id,Status,Origin,Priority from Case where id = :case1.Id];
        System.assertEquals('High',caseUp.Priority);
        
        Case case2 = new Case();
        case2.Status = 'Working';
        case2.Priority = 'Low';
        case2.Origin = 'Web';
        insert case2;
        Case caseUp2 = [select id,Status,Origin,Priority from Case where id = :case2.Id];
        System.assertEquals('Medium',caseUp2.Priority);
        
        Case case3 = new Case();
        case3.Status = 'Working';
        case3.Priority = 'Medium';
        case3.Origin = 'Email';
        insert case3;
        Case caseUp3 = [select id,Status,Origin,Priority from Case where id = :case3.Id];
        System.assertEquals('Low',caseUp3.Priority);
        
    }
   @istest static void testHighCase(){
         Case case1 = new Case();
        case1.Status = 'Working';
        case1.Priority = 'High';
        case1.Origin = 'Phone';
        insert case1;
        Case caseUp = [select id,Status,Subject,Priority from Case where id = :case1.Id];
        System.assertEquals('High Priority Case - Immediate Attention',caseUp.subject);        
    }
    @istest static void testCaseReason(){
        Case case1 = new Case();
        case1.Status = 'New';
        case1.Priority = 'High';
        case1.Origin = 'Phone';
        insert case1;
        case1.Status = 'Escalated';
        update case1;
        
        Case caseUp = [select id,Status,Reason from Case where id = :case1.Id];
        
        System.assertEquals('Performance',caseUp.Reason);        
    }
    
   @istest static void testcaseDueDate(){
        
     Case case1 = new Case();
        case1.Status = 'New';
        case1.Priority = 'High';
        case1.Origin = 'Phone';
        insert case1;
        Case caseUp = [select id,Priority,Due_date__c from Case where id = :case1.Id];
        System.assertEquals(Date.today().addDays(1),caseUp.Due_Date__c);
       
       
       Case case2 = new Case();
        case2.Status = 'New';
        case2.Priority = 'Medium';
        case2.Origin = 'Phone';
        insert case2;
        Case caseUp2 = [select id,Priority,Due_date__c from Case where id = :case2.Id];
        System.assertEquals(Date.today().addDays(3),caseUp2.Due_Date__c);
       
       
       Case case3 = new Case();
        case3.Status = 'New';
        case3.Priority = 'High';
        case3.Origin = 'Phone';
        insert case3;
        Case caseUp3 = [select id,Priority,Due_date__c from Case where id = :case3.Id];
        System.assertEquals(Date.today().addDays(5),caseUp3.Due_Date__c);
       
   }
}
