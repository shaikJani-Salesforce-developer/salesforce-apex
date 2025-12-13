trigger CourseTrigger on Course__c (before insert,before Update,before delete) {

    //Course availability should be always online

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Course__c newCourse : Trigger.New){
            if(newCourse.Availablility__c == 'Offline'){
                newCourse.addError('Course Availablity Should Be Online Only');
            }
            else{
                newCourse.Availablility__c = 'Online';
            }
        }
    }
    //Course Old fee is must 
    if(Trigger.isBefore && Trigger.isInsert){
        for(Course__c newCourse : Trigger.New){
            if(newCourse.Old_Fee__c == NULL){ 
                newCourse.addError('Enter Course Old Fee');
            }
        }
    }
    /*Course new fee
Newfee < 5000 ⇒ approval status ⇒ Rejected 
Newfee >= 5000 and newfie <= 20000
     ⇒ approval status ⇒ Pending 
Newfee > 20000 ⇒ Accepted
*/ 
    if(Trigger.isBefore && Trigger.isInsert){
        for(Course__c newCourse : Trigger.new){
            if(newCourse.New_Fee__c < 5000){
                newCourse.Approval_Status__c = 'Rejected';
            }
            else if(newCourse.New_Fee__c >= 5000 && newCourse.New_Fee__c <= 20000){
                newCourse.Approval_Status__c = 'Pending';
            }
            else{
                newCourse.Approval_Status__c = 'Accepted';
            }
        }
    }
    //Do not allow delete any record if the approval status is accepted for the course object.

    if(Trigger.isBefore && Trigger.isdelete){
        for(Course__c oldCourse : Trigger.old){
            if(oldCourse.Approval_Status__c == 'Accepted'){
                oldCourse.addError('You Cannot delete the Accepted Record');
            }
        }
    }
   
    
    
}
