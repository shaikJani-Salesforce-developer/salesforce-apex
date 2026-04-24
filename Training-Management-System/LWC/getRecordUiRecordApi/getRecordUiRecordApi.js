import { LightningElement,api,wire } from 'lwc';
import { getRecord, getFieldValue, getFieldDisplayValue } from 'lightning/uiRecordApi';
import NAME_FIELD from "@salesforce/schema/Account.Name";
import REVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";

export default class GetRecordUiRecordApi extends LightningElement {
    name 
    annualrevenue
    @api recordId 

    @wire(getRecord, { recordId : '$recordId', fields :[NAME_FIELD,REVENUE_FIELD]})
     accountData({data}){
        if(data){
            console.log()
            this.name = getFieldDisplayValue(data,NAME_FIELD)
            this.annualrevenue = getFieldDisplayValue(data,REVENUE_FIELD)
        }
     }

}