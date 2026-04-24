import { LightningElement ,wire } from 'lwc';
import fetchOppRecords from '@salesforce/apex/opportunityClass.fetchOppRecords';
export default class OpportunityWireComponent extends LightningElement {
    @wire(fetchOppRecords) oppsRecords;
}