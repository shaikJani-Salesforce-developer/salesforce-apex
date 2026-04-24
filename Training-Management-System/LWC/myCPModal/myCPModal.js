import { LightningElement } from 'lwc';

export default class MyCPModal extends LightningElement {
    handleClick(){
        this.template.querySelector('c-my-c-modal').showModal();
    }
}