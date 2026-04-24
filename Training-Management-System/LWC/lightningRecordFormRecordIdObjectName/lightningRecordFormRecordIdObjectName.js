import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class LightningRecordFormRecordIdObjectName extends LightningElement {
  @api recordId //this is universal any record in any object
  @api objectApiName  // this is universal any object inside application

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