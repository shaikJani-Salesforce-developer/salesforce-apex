import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
 import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class CreateRecordUiRecordApi2 extends LightningElement {

  fieldvalues = {}
  handleInputChange(event){
     const{name, value} = event.target
     this.fieldvalues[name] = value;
  }

   saveRecord(){
       const recordInput = { apiName: CONTACT_OBJECT.objectApiName, fields :this.fieldvalues };
       createRecord(recordInput).then(result=>{
                        const createevent = new ShowToastEvent({
                      title: "Contact",
                      message:"Contact created successfully",    
                      variant: "success",
                      mode:"dismissible"
                      });
                      this.dispatchEvent(createevent);
                      this.template.querySelector('form.createForm').reset();
                      this.fieldvalues = {}
                         })
                         .catch(error=>{
                        console.log(error); 
                        const createevent = new ShowToastEvent({
                         title: "Error",
                         message: error.body.message,
                         variant: "error"
                          });
                         this.dispatchEvent(createevent);


                         })
   }
}