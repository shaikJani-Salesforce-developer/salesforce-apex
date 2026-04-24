import { LightningElement ,wire} from 'lwc';
import { getObjectInfo, getPicklistValues } from "lightning/uiObjectInfoApi";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import ACCOUNT_OBJECT from "@salesforce/schema/Account";

export default class GetPicklistvalues extends LightningElement {
    pickedIndustryValues= ''
    industryValueOptions = []
     //this will bring object defaultRecordTypeId 
    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo

    //to bring the picklist values this process help 
    @wire(getPicklistValues, { recordTypeId: "$objectInfo.data.defaultRecordTypeId", fieldApiName: INDUSTRY_FIELD })
    industryPickListValues({data,error}){
        if(data){
            console.log(data)
            this.industryValueOptions = [...this.receivePicklistData(data)]
        }
        if(error){
            console.log(error)
        }
    }
    
    receivePicklistData(data){
      //we have to generate the structure 
      //whenever we transform the data , we have use map options
      //return map to the fucntion
      return data.values.map(item=>({label: item.label, value: item.value}))
    }
    handleIndustryChange(event){
        this.pickedIndustryValues = event.detail.value;
    }
}