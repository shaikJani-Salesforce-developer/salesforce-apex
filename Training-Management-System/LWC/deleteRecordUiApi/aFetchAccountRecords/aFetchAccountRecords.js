import { LightningElement,wire } from 'lwc';
import getAccRecords from '@salesforce/apex/opportunityClass.getAccRecords';
export default class AFetchAccountRecords extends LightningElement {
     
    @wire(getAccRecords) storeAccounts;
   accountRecords({data,error}){
     if(data){
         this.storeAccounts = data;
     }
     else if(error){
        console.log(error)
     }
   }
}