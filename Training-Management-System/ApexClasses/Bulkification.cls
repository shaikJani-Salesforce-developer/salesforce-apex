public class Bulkification {
    
    public static void ProcessingBulkRecords(){
        // here we inserting mutiple records by using collections 
        // syntax for list class --> list<datatype> listobj = new list<datatype>();
        // here key points
        // class = Objects in Model
        //  class is a user defined datatype -->  class = datatype
        //  so object = datatype 
        //  object is Doctor --> Doctor ---> datatype = Doctor
        // syntax for creating object --> className obj = new className();
        //loading the values --> obj.fieldname = value;
             Doctor__c doctor1 = new Doctor__c();
             doctor1.Name = 'DR.ARVIND';
             doctor1.Hospital_Name__c = 'Yashoda Hospitals';
             doctor1.Available_Timings__c = '9AM - 12PM';
             doctor1.Doctor_ID__c = 'DOC-4789';
             doctor1.Doctor_License_Number__c = 'DLN-124578';
             doctor1.Experience__c = 12;
             doctor1.Specialization__c = 'Neurologist';
             doctor1.Consultation_Fee__c = 1000;
             doctor1.Phone__c = '9046789076';
             doctor1.Email__c = 'aravind@gmail.com';
             doctor1.ATM_Number__c = '4567 8887 2567 7890';
             doctor1.PAN_Number__c = 'HKLYH7890K';
             
        
        // now loading the values for another record
            Doctor__c doctor2 = new Doctor__c();
            doctor2.Name = 'DR.VEERA SHANKAR';
            doctor2.Hospital_Name__c = 'Aditya Hospitals';
            doctor2.Available_Timings__c = '9AM - 12PM';
            doctor2.Doctor_ID__c = 'DOC-2788';
            doctor2.Doctor_License_Number__c = 'DLN-144569';
            doctor2.Experience__c =10;
            doctor2.Specialization__c = 'Cardiologist';
            doctor2.Consultation_Fee__c = 1000;
            doctor2.Phone__c = '9848022441';
            doctor2.Email__c = 'veera@gmail.com';
            doctor2.ATM_Number__c = '4567 8906 7890 2567';
            doctor2.PAN_Number__c = 'HJKYI9067O';
          
        
        // now loading values for 3rd record
          Doctor__c doctor3 = new Doctor__c();
            doctor3.Name ='DR.JOSEPH';
            doctor3.Hospital_Name__c = 'Sun Shine Hospitals';
            doctor3.Available_Timings__c = '9AM - 12PM';
            doctor3.Doctor_ID__c = 'DOC-2566';
            doctor3.Doctor_License_Number__c = 'DLN-133569';
            doctor3.Experience__c =13;
            doctor3.Specialization__c = 'Orthopedic';
            doctor3.Consultation_Fee__c = 500;
            doctor3.Phone__c = '8008840960';
            doctor3.Email__c = 'Joseph@gmail.com';
            doctor3.ATM_Number__c ='6789 7842 6112 4567';
            doctor3.PAN_Number__c = 'GHTIO8976I';
        
           
        
        // now loading values for 4th record
            Doctor__c doctor4 = new Doctor__c();
            doctor4.Name = 'DR.KALPANA';
            doctor4.Hospital_Name__c = 'Aparna Hospitals';
            doctor4.Available_Timings__c = '9AM - 1PM';
            doctor4.Doctor_ID__c = 'DOC-2599';
            doctor4.Doctor_License_Number__c = 'DLN-145579';
            doctor4.Experience__c =14;
            doctor4.Specialization__c = 'Dentist';
            doctor4.Consultation_Fee__c = 500;
            doctor4.Phone__c = '8080808080';
            doctor4.Email__c = 'kalpana@gmail.com';
            doctor4.ATM_Number__c = '5678 2456 7890 4567';
            doctor4.PAN_Number__c = 'YUOJH8965L';
          
        
        // now loading the values for 5th record
        Doctor__c doctor5 = new Doctor__c();
          doctor5.Name = 'DR.RAJA KUMAR';
          doctor5.Hospital_Name__c = 'Star Hospitals';
          doctor5.Available_Timings__c = '9AM - 1PM';
          doctor5.Doctor_ID__c = 'DOC-4890';
          doctor5.Doctor_License_Number__c = 'DLN-141191';
          doctor5.Experience__c = 5;
         doctor5.Specialization__c = 'Neurologist';
         doctor5.Consultation_Fee__c = 1000;
         doctor5.Phone__c = '9090909091';
         doctor5.Email__c = 'raja@gmail.com';
         doctor5.ATM_Number__c = '4567 9660 6789 9065';
         doctor5.PAN_Number__c = 'GHYTR9078L';
         
        
        //now list class comes into picture 
        //some key points 
        //class = Objects in Model
        //  class is a user defined datatype -->  class = datatype
        //  then object = datatype
        //  object is Doctor --> Doctor ---> datatype = Doctor
        //syntax for list class --> list<datatype> listobj = new list<datatype>();
                    list<Doctor__c> Doctors = new list<Doctor__c>();
        // list method --> add()
        // calling methods --> obj.memMethod();
         Doctors.add(doctor1);
        Doctors.add(doctor2);
         Doctors.add(doctor3);
        Doctors.add(doctor4);
        Doctors.add(doctor5);
        
        // now insert operation
        // syntax --> insert obj;
        insert Doctors;
                   
    }

}
