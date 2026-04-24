import { LightningElement } from 'lwc';
import fetchOppRecords from '@salesforce/apex/opportunityClass.fetchOppRecords';

export default class AFetchAccountsImperative extends LightningElement {
    opportunityrecords;
    handleClick(){
        getOppRecords().then(result=>{
            //store the results in the property opportunity records
            this.opportunityrecords = result
        }).catch(error=>{
            console.log(error)
        })
    }
}