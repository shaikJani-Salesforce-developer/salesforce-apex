import { LightningElement } from 'lwc';

export default class MyParentSpinner extends LightningElement {

    handleClick(){
        this.template.querySelector('c-my-child-spinner').startAnimation();
    }
}