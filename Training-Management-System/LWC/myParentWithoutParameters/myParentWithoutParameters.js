import { LightningElement } from 'lwc';

export default class MyParentWithoutParameters extends LightningElement {
    handleClick(){
        //show the alert message coming from child component
        this.template.querySelector('c-my-child-without-parameters').showAlertMessage();

        
    }
}