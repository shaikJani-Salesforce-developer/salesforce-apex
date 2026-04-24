import { LightningElement } from 'lwc';
import getOppRecordsImpParameters from '@salesforce/apex/opportunityClass.getOppRecordsImpParameters';
export default class AFetchOppsImperative extends LightningElement {
 //to store the opps take property \
  opprecords;
  opportunityrecords
  handleNameChange(event){
    this.opprecords = event.target.value

  }

    handleClick(){
        getOppRecordsImpParameters({searchingvalue:this.opprecords}).then(result=>{
            this.opportunityrecords = result
        }).catch(error=>{
            console.log(error);
        })
    }
}