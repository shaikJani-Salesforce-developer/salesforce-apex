import { LightningElement } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class LightningRecordEditform2 extends LightningElement {

    handleSubmit(){ //record get saved,toast message 
    const createevent = new ShowToastEvent({
      title: "Contact Record",
      message:
        "Contact Record Updated successfully",
        variant: "success",
        mode:"dismissible"
    });
    this.dispatchEvent(createevent);

   }

}