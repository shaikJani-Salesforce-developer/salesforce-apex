import { LightningElement,api,wire } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from "@salesforce/schema/Account.Name";
import REVENUE_FIELD from "@salesforce/schema/Account.AnnualRevenue";
import INDUSTRY_FIELD from "@salesforce/schema/Account.Industry";
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import FAX_FIELD from '@salesforce/schema/Account.Fax';
import { getObjectInfo, getPicklistValuesByRecordType } from "lightning/uiObjectInfoApi";
import { getRecord ,updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";


const FIELDS = [NAME_FIELD,REVENUE_FIELD,INDUSTRY_FIELD,RATING_FIELD,PHONE_FIELD,FAX_FIELD]
export default class UpdateRecordUiRecordApi extends LightningElement {

   @api recordId
   //define the properties for each field
   name =''
   annualrevenue =''
   fax =''
   rating =''
   industry =''
   phone =''
    ratingOptions =[]
    industryOptions =[]
   //use the getters to map field names to properties 
  get fieldsToPropertyMap(){
      return{
        Name : 'name',
        Phone : 'phone',
        Fax : 'fax',
        Industry : 'industry',
        Rating : 'rating',
        AnnualRevenue :'annualrevenue'
      }
   }
  @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
     getObjectInfo;

     @wire(getPicklistValuesByRecordType, {
    objectApiName: ACCOUNT_OBJECT,recordTypeId: "$getObjectInfo.data.defaultRecordTypeId",
  })
  //function to receive data 
    receiveData({data,error}){
        if(data){
            console.log(data)
            
            this.industryOptions = this.receivePicklistData(data.picklistFieldValues.Industry)
            this.ratingOptions = this.receivePicklistData(data.picklistFieldValues.Rating)
        }
        if(error){
            console.log(error)
        }
    }
    receivePicklistData(data){
        return data.values.map(item=>({label :item.label, value:item.value}))
    }
        //get the current data --> getRecord
        @wire(getRecord, { recordId: '$recordId', fields :FIELDS})
        handleRecord({data,error}){
           if(data){
            const fields = data.fields
            //name,rating,phone,fax,industry,annual
            if(fields.Name && fields.Name.value !==undefined){
                this.name = fields.Name.value;
            }
            if(fields.Phone && fields.Phone.value !==undefined){
                this.phone = fields.Phone.value;
            }
            if(fields.Fax && fields.Fax.value !==undefined){
                this.fax = fields.Fax.value;
            }
            if(fields.Rating && fields.Rating.value !==undefined){
                this.rating = fields.Rating.value;
            }
            if(fields.Industry && fields.Industry.value !==undefined){
                this.industry = fields.Industry.value;
            }
            if(fields.AnnualRevenue && fields.AnnualRevenue.value !==undefined){
                this.annualrevenue= fields.AnnualRevenue.value;
            }
            else if(error){
               console.log(error)
            }
        } 
        }

         //handle input changes 
         //uses dataset used for field maping --> dynamically--> fieldsToPropertymap
         //field mapping needs to be done 
         handleChange(event){
              //field mapping -> dynamically 
             const fieldName = event.target.dataset.field 
             const propertyName = this.fieldsToPropertyMap[fieldName]
             if(propertyName){
                this[propertyName] = event.target.value
             }
         }
         //on click of the button it should update therecord
         updateAccount(){
            const fieldsToUpdate = {
               Id: this.recordId,
               Name : this.name,
               Phone : this.phone,
               AnnualRevenue : this.annualrevenue,
               Fax : this.fax,
               Industry : this.industry,
               Rating :this.rating

            }
            const recordInput = {fields:fieldsToUpdate}
            updateRecord(recordInput).then(result=>{
                       const updateevent = new ShowToastEvent({
                         title: "Account",
                        message:
                           "Account updated successfully",
                            variant: "info",
                            mode:"sticky"
                           });
                           this.dispatchEvent(updateevent);
                       }) .catch(error=>{
                           const createevent = new ShowToastEvent({
                         title: "Error",
                         message: error.body.message,
                         variant: "error"
                          });
                         this.dispatchEvent(createevent);
                       })
         }
}
