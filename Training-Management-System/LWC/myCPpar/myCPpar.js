import { LightningElement } from 'lwc';


export default class MyCPpar extends LightningElement {


    handleStatusChange(event){
         const status= event.detail.value;
         this.template.querySelector('c-my-cpar').filterRecords(status);
    }
    get statusOptions() {
        return [
            { label: 'New', value: 'New' },
            { label: 'In Progress', value: 'In Progress' },
            { label: 'Closed', value: 'Closed' },
        ];
    }
}
