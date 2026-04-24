import { LightningElement } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from "@salesforce/schema/Account.Name";
import REVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import FAX_FIELD from '@salesforce/schema/Account.Fax';

export default class LightningRecordFormMode extends LightningElement {
  // load imported features in properties 
   objectname = ACCOUNT_OBJECT
   accountfields = [NAME_FIELD,REVENUE_FIELD,INDUSTRY_FIELD,RATING_FIELD,PHONE_FIELD,FAX_FIELD]
     
   handleSubmit(){ //record get saved,toast message 
    const updateevent = new ShowToastEvent({
      title: "Account",
      message:
        "Account Record Updated successfully",
        variant: "success",
        mode:"dismissible"
    });
    this.dispatchEvent(updateevent);

   }
}