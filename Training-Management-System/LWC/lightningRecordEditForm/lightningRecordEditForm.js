import { LightningElement } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import CONTACT_OBJECT from "@salesforce/schema/Contact";
import FIRSTNAME_FIELD from "@salesforce/schema/Contact.FirstName";
import LASTNAME_FIELD from "@salesforce/schema/Contact.LastName";
import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
import EMAIL_FIELD from "@salesforce/schema/Contact.Email";
import FAX_FIELD from "@salesforce/schema/Contact.Fax";
import TITLE_FIELD from "@salesforce/schema/Contact.Title";
import ACCOUNTNAME_FIELD from "@salesforce/schema/Contact.AccountId";




export default class LightningRecordEditForm extends LightningElement {
    objectname = CONTACT_OBJECT;
    fields = {
    firstnamefield : FIRSTNAME_FIELD,
    lastnamefield : LASTNAME_FIELD,
    phonefield : PHONE_FIELD,
    emailfield : EMAIL_FIELD,
    faxfield : FAX_FIELD,
    titlefield : TITLE_FIELD,
    accountnamefield : ACCOUNTNAME_FIELD
}
    handleSubmit(){ //record get saved,toast message 
    const createevent = new ShowToastEvent({
      title: "Contact Record",
      message:
        "Contact Record Created successfully",
        variant: "success",
        mode:"dismissible"
    });
    this.dispatchEvent(createevent);

   }

}