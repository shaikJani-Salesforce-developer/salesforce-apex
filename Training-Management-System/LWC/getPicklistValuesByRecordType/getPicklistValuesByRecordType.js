import { LightningElement ,wire} from 'lwc';
import { getObjectInfo, getPicklistValuesByRecordType } from "lightning/uiObjectInfoApi";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";

export default class GetPicklistValuesByRecordType extends LightningElement {
    
     pickedIndustryValues 
     pickedRatingValues
     industryValueOptions
     ratingValueOptions

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
     getObjectInfo;

     @wire(getPicklistValuesByRecordType, {
    objectApiName: ACCOUNT_OBJECT,recordTypeId: "$getObjectInfo.data.defaultRecordTypeId",
  })
  //function to receive data 
    receiveData({data,error}){
        if(data){
            console.log(data)
            
            this.industryValueOptions = this.receivePicklistData(data.picklistFieldValues.Industry)
            this.ratingValueOptions = this.receivePicklistData(data.picklistFieldValues.Rating)
        }
        if(error){
            console.log(error)
        }
    }
    receivePicklistData(data){
        return data.values.map(item=>({label :item.label, value:item.value}))
    }
        handleChange(event){

          if(event.target.value=== 'Industry'){
            this.pickedIndustryValues = event.target.value;
          }
          if(event.target.value === 'Rating'){
            this.pickedRatingValues = event.target.value;
          }
        }
        //anpother handle change method 
        /* 
          const {name,value} = event.target
          if(name === 'Industry'){
             this.pickedIndustryValues = value
          }
             if(name === 'Rating){
             this.pickedRatingValues = value;
             }
        
        */ 
}