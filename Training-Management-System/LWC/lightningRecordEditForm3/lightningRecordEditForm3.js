import { LightningElement ,api} from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class LightningRecordEditForm3 extends LightningElement {
    @api recordId;
  @api objectApiName;

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