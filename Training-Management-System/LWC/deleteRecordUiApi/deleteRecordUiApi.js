import { LightningElement ,api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';


export default class DeleteRecordUiApi extends LightningElement {
  @api recordId
  //on click of the delete button that recprd should delete 

  deleteRecord(){
    //record should get deleted 
    deleteRecord(this.recordId).then(()=>{
        console.log('Delete Record')
       }).catch(error=>{
        console.log(error);
       })

  }
}