@istest
public class RelatedOperationTest {
    @istest static void testInsert(){
        RelatedOperation.BuildingHospitalRelation();
      Integer nurseCount  = [select count() from Nurse__c];
        System.assertEquals(1,nurseCount);
     Nurse__c nurse  = [select id,name from Nurse__c Where name IN('Parvathi')];
        System.assertEquals('Parvathi',nurse.name);
        
        Integer doctorCount = [select count() from Doctor__c];
        System.assertEquals(1,doctorCount);
        Doctor__c doctor = [select id,name from Doctor__c where name IN('DR.SHIVA RAM')];
        System.assertEquals('DR.SHIVA RAM',doctor.name);
        
        integer medicineCount = [select count() from Medicine__c];
        System.assertEquals(1,medicineCount);
        Medicine__c medicine = [select id,name from Medicine__c where name IN('Dolo 650')];
        System.assertEquals('Dolo 650',medicine.name);
        
        integer patientCount = [select count() from Patient__c];
        system.assertEquals(1,patientCount);
        Patient__c patient = [select id,name,Doctor__c,Nurse__c,Medicine__c from Patient__c where Doctor__c = :doctor.id and Nurse__c =:nurse.id and Medicine__c =:medicine.id];
        System.assertEquals(doctor.id,patient.Doctor__c);
        System.assertEquals(nurse.id,patient.Nurse__c);
        System.assertEquals(medicine.id,patient.Medicine__c);
        
        
    }
}
