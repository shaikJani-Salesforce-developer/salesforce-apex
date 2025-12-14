@istest
public class BulkificationTest {
    @istest static void testInsert(){
        Bulkification.ProcessingBulkRecords();
     integer doctorCount  = [select count() from Doctor__c];
        System.assertEquals(5,doctorCount);
     list<Doctor__c> doctors = [select id,Name from Doctor__c where Name IN('DR.ARVIND','DR.VEERA SHANKAR','DR.JOSEPH','DR.KALPANA','DR.RAJA KUMAR')];
        System.assertEquals('DR.ARVIND',doctors[0].name);
        System.assertEquals('DR.VEERA SHANKAR',doctors[1].name);
        System.assertEquals('DR.JOSEPH',doctors[2].name);
        System.assertEquals('DR.KALPANA',doctors[3].name);
        System.assertEquals('DR.RAJA KUMAR',doctors[4].name);
    }
}
