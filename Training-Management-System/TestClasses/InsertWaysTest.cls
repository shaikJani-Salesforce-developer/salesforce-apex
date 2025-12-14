@isTest
public class InsertWaysTest {
    @istest static void testInsert(){
        InsertWays.insertrecordsin5ways();
       Integer booksCount = [select count() from Book__c];
        System.assertEquals(19,booksCount);
        
    }
}
