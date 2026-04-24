public with sharing class opportunityClass {
    @AuraEnabled(cacheable=true)
    public static list<Opportunity> fetchOppRecords(){
        // bring data from org by writing the SOQL 
       return [SELECT id, Name,StageName,Amount,CloseDate FROM Opportunity LIMIT 10];
    }
    // i want to fetch the values depends on parameter string won
    @AuraEnabled(cacheable = true)
    public static list<Opportunity> getOppRecords(string won){
      
       return [SELECT id,Name, StageName FROM Opportunity WHERE StageName = :won];
    }

      @AuraEnabled(cacheable = true)
    public static list<Opportunity> getOppRecordsImpParameters(string searchingvalue){
      
       return [SELECT id,Name, StageName,CloseDate,Amount FROM Opportunity WHERE Name LIKE:searchingvalue+'%'];
    }



     @AuraEnabled(cacheable=true)
     public static list<Account> getAccRecords(){
             //fetch the account records 
           return  [SELECT id,Name,Industry,Type from Account ];
      }
}