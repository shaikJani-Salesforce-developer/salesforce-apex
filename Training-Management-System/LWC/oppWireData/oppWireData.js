import { LightningElement,wire } from 'lwc';
import getOppRecords from '@salesforce/apex/OpportunityClass.getOppRecords';
export default class OppWireData extends LightningElement {

    //store the fetched records in variable
    stagename = ''
       @wire(getOppRecords,{won :'$stagename'}) opportunities

       get selectstage() {
        return [
            { label: 'Prospecting', value: 'Prospecting' },
            { label: 'Qualification', value: 'Qualification' },
            { label: 'Closed Won', value: 'Closed Won' },
        ];
    }

    handleChange(event) {
        this.stagename = event.target.value;
    }
        
}