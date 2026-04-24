import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import FAX_FIELD from '@salesforce/schema/Account.Fax';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';

const fields = [
    NAME_FIELD,
    PHONE_FIELD,
    FAX_FIELD,
    RATING_FIELD,
    INDUSTRY_FIELD,
    REVENUE_FIELD
];

export default class GetAccountByImporting extends LightningElement {

    accountDetailsf;

    @wire(getRecord, { recordId: '001dL000023yp1iQAA', fields })
    accountRecordValues({ data, error }) {
        if (data) {
            this.accountDetailsf = data.fields;
        } else if (error) {
            console.error(error);
        }
    }
}