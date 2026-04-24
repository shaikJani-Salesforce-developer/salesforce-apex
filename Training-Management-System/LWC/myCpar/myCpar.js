import { LightningElement,api } from 'lwc';


export default class MyCpar extends LightningElement {


    records =[]
    allRecords = [
        {id :1, name :'Case A',status :'New'},
        {id :2, name :'Case B',status :'In Progress'},
        {id :3, name :'Case C',status :'Closed'},
    ]
   @api  filterRecords(status){
        this.records = this.allRecords.filter(record =>record.status===status)
    }
}
