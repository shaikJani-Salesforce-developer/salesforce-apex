import { LightningElement,wire } from 'lwc';
 import userId from '@salesforce/user/Id';
 import { getRecord } from 'lightning/uiRecordApi';
 import NAME_FIELD from '@salesforce/schema/User.Name';
 import EMAIL_FIELD from '@salesforce/schema/User.Email';
 const FIELDS = [NAME_FIELD,EMAIL_FIELD]

export default class GetUserDetails extends LightningElement {
    //load the user id in the property
    userIdDetails = userId
    //to get the user details we need user record id =  005dL00001iVIYHQA4
    userDetailsf 
    @wire(getRecord,{ recordId:"$userIdDetails", fields: FIELDS})

    fetchUserDetails({data,error}){
        if(data){
            console.log(data)
            this.userDetailsf = data.fields 
        }
        if(error){
            console.log(error)
        }
    }
    //by using property
    @wire(getRecord,{ recordId:"$userIdDetails", fields: FIELDS})
     userDetailp;
}