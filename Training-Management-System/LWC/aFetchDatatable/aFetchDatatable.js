import { LightningElement ,wire } from 'lwc';
import fetchOppRecords from '@salesforce/apex/opportunityClass.fetchOppRecords';
const oppcolumns = [
    { label: 'Opportunity Name', fieldName: 'Name' },
    { label: 'Amount', fieldName: 'Amount',},
    { label: 'Close Date', fieldName: 'CloseDate',},
    { label: 'Stage Name', fieldName: 'StageName'},
    
];
export default class AFetchDatatable extends LightningElement {
   opprecords;
   opportunityfields = oppcolumns
    @wire (fetchOppRecords)
   getOppRecords({data,error}){
    if(data){
        this.opprecords = data
    }
    else if(error){
        console.log(error)
    }
   }
}