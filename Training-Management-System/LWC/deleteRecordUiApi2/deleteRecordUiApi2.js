import { LightningElement } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class DeleteRecordUiApi2 extends LightningElement {
  //take the property to receive event
  recordId 
  handleChange(event){
   this.recordId = event.target.value;
}

  handleDelete(){
    //record should get deleted 
    deleteRecord(this.recordId).then(()=>{
        console.log('Delete Record')
          const deleteevent = new ShowToastEvent({
          title: "Record",
          message:
        "Record deleted successfully",
        variant: "success",
        mode:"dismissible"
    });
    this.dispatchEvent(deleteevent);

       }).catch(error=>{
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