import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { LightningElement } from 'lwc';

export default class ToastMessage extends LightningElement {

    handleCreateClick(){
      const createevent = new ShowToastEvent({
      title: "Course Record",
      message:
        "Course created successfully",
        variant: "success",
        mode:"dismissible"
    });
    this.dispatchEvent(createevent);
    }

    handleUpdateClick(){
        const updateevent = new ShowToastEvent({
      title: "Course Record",
      message:
        "Course updated successfully",
        variant: "info",
        mode:"sticky"
    });
    this.dispatchEvent(updateevent);

    }
    handleDeleteClick(){
      const deleteevent = new ShowToastEvent({
      title: "Course Record",
      message:
        "Course deleted successfully",
        variant: "error",
        mode:"dismissible"
    });
    this.dispatchEvent(deleteevent);
    }

    handleConvertClick(){
     const convertevent = new ShowToastEvent({
      title: "Lead Conversion",
      message:
        "This Lead Cannot be Converted",
        variant: "warning",
        mode:"sticky"
    });
    this.dispatchEvent(convertevent);
    }
}