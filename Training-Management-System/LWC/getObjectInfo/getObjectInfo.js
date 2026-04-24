import { LightningElement,wire } from 'lwc';
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";
export default class GetObjectInfo extends LightningElement {
 
     defaultRecordTypeId;
     apiName;
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    //we can take property or function but u can take function 

   
    objectInfo({data,error}){
        if(data){
            console.log(data)
           this.apiName = data.apiName
         this.defaultRecordTypeId = data.defaultRecordTypeId
        }

        if(error){
            console.log(error)
        }
    }
}