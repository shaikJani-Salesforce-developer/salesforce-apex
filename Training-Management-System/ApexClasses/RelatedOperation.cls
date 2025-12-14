public class RelatedOperation {
    
  public static void  BuildingHospitalRelation(){
      
      //Doctor,Nurse,Patient,Medicine objects are in relationship
      //Patient is Chid Object -->  Doctor,Nurse,Medicine objects are parent objects
      //for inserting child record we should have parent record already 
      //step 1-->  create parent record first
      //step 2--> after create child record 
      //for inserting record we need memory space --> for space create the object
      //syntax--> className obj = new className();
      //loading the values --> obj.memMethod();
           Nurse__c nurse1 = new Nurse__c();
          nurse1.Name ='Parvathi';
          nurse1.Timings__c = '8AM - 6PM';
          nurse1.Gender__c = 'Female';
          nurse1.Salary__c = 15000;
          nurse1.Date_Of_Birth__c = Date.newInstance(1990, 8, 1);
          nurse1.Mobile__c = '8008840960';
         nurse1.Phone__c = '25678';
         nurse1.Email__c = 'parvathi@gmail.com';
          // now insert operation
          // syntax --> insert obj;
          insert nurse1;
      // if statement 
      if(nurse1.id !=null){
          System.debug('Nurse Record :'+nurse1);
      }
      
           //now create another parent record --> Doctor object
           Doctor__c Doctor1 = new Doctor__c();
             Doctor1.Name = 'DR.SHIVA RAM';
             Doctor1.Available_Timings__c = '8AM - 12PM';
             Doctor1.Doctor_ID__c = 'DOC-7897';
             Doctor1.Consultation_Fee__c = 1000;
             Doctor1.Doctor_License_Number__c ='DLN-146745';
             Doctor1.Experience__c = 10;
             Doctor1.Hospital_Name__c = 'Ramesh Hospitals';
             Doctor1.Phone__c ='8008840960';
             Doctor1.Specialization__c = 'Neurologist';
             Doctor1.ATM_Number__c = '4567 7654 8900 6700';
             Doctor1.PAN_Number__c ='GHJKT7890H';
            Doctor1.Email__c = 'shivaram@gmail.com';
           // insert operation
           //  syntax --> insert obj;
              insert Doctor1;
              // if statement 
      if(Doctor1.id !=null){
          System.debug('Doctor Record :'+Doctor1);
      }
           
          // another record required --> Medicine Object
           Medicine__c medicine1 = new Medicine__c();
            medicine1.Name = 'Dolo 650';
            medicine1.Dosage__c = '2 per day';
            medicine1.Type__c = 'Tablet';
            medicine1.Price__c =100;
         //now insert operation
         //syntax --> insert medicine1;
            insert medicine1;
      //if statement 
      if(medicine1.id !=null){
          System.debug('Medicne record :'+medicine1);
      }

      
      
      // now lets create child record --> patient object
      // for inserting record we need memory space --> for space create the object
      // syntax for object --> classsName obj = new className();
          Patient__c patient1 = new Patient__c();
          patient1.Name ='Neeraj';
          patient1.Desease__c = 'Fever';
          patient1.Doctor__c = Doctor1.id;
          patient1.Medicine__c = medicine1.id;
          patient1.Nurse__c = nurse1.id;
          patient1.Consulation_Fee__c =1000;
          patient1.Join_Date__c =Date.newInstance(2025, 8, 28);
          patient1.Discharge_Date__c = Date.newInstance(2025,9, 1);
          patient1.Date_of_birth__c = Date.newInstance(1995, 08, 1);
          patient1.Fee_Paid__c = 6000;
          patient1.Gender__c = 'Male';
          patient1.Payment_Status__c = 'Paid';
          patient1.Phone__c = '25678';
          patient1.Status__c = 'Discharged';
          patient1.Mobile__c ='9091909190';
          patient1.Address__c ='Ameerpet';
          patient1.Email__c = 'neeraj@gmail.com';
         // now insert operation 
         // syntax --> insert obj;
           insert patient1;
      //if statement
        if(patient1.id !=null){
           System.debug('Patient record :'+patient1);
      }
                   
    }
}
