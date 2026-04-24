import { LightningElement } from 'lwc';

export default class LifeCycleChatgpt extends LightningElement {
    records = [];
    
    allRecords =[
       {id : 1, name : 'David Miller'},
       {id :2, name : 'Brevis'},
       {id :3, name : 'Fereera'}
    ]
    connectedCallback() {
       this.records = this.allRecords
       console.log('Data Loaded in connectedCallback');
    }
}