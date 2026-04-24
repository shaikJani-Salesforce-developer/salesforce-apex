import { LightningElement } from 'lwc';

 import { createRecord } from 'lightning/uiRecordApi';
 import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class CreateRecordUiRecordApi extends LightningElement {


    accname;
    accphone;
    accfax;

    handleInputNameChange(event){
         this.accname = event.target.value
    }
    handleInputPhoneChange(event){
       this.accphone = event.target.value
    }
    handleInputFaxChange(event){
         this.accfax = event.target.value
    }
    saveRecord(){
        const fields = {
            'Name' : this.accname,
            'Phone' : this.accphone,
            'Fax' : this.accfax
        }
        const recordInput = { apiName:'Account', fields };
           createRecord(recordInput).then(data =>{
                const createevent = new ShowToastEvent({
                      title: "Account",
                      message:"Account created successfully",    
                      variant: "success",
                      mode:"dismissible"
                      });
                      this.dispatchEvent(createevent);
                      
                })
                  .catch(error=>{
            console.log(error); // 👈 MUST ADD
             const createevent = new ShowToastEvent({
               title: "Error",
             message: error.body.message,
             variant: "error"
           });
               this.dispatchEvent(createevent);
})
    }
}