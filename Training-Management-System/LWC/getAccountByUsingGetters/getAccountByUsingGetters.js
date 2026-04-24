import { LightningElement,wire,api} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ["Lead.Name","Lead.Title","Lead.Phone","Lead.Status","Lead.Email","Lead.Industry","Lead.Rating"]
export default class GetAccountByUsingGetters extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId:'$recordId', fields:FIELDS })
    leadRecord

    get Name(){
        return this.leadRecord.data.fields.Name.value
    }
    get Phone(){
        return this.leadRecord.data.fields.Phone.value
    }
    get Title(){
        return this.leadRecord.data.fields.Title.value
    }
    get Status(){
        return this.leadRecord.data.fields.Status.value
    }
    get Email(){
        return this.leadRecord.data.fields.Email.value

    }
    get Rating(){
        return this.leadRecord.data.fields.Rating.value
    }
    get Industry(){
        return this.leadRecord.data.fields.Industry.value
    }
}