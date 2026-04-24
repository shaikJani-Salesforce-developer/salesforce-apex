import { LightningElement } from 'lwc';

export default class CparentLifeCycle extends LightningElement {
     isChecked = false
    //parent child cycle
    constructor(){
       super()
       console.log('constructor :Parent')
    }
    connectedCallback() {
       console.log('constructor :Parent')
    }

    renderedCallback(){
        console.log('constructor :Parent')
    }
    errorCallback(error, stack) {
        console.log('constructor :Parent')
    }
    disconnectedCallback() {
        console.log('constructor :Parent')
    }
    checkedUnchecked(event){
       this.isChecked = event.target.checked;
    }
}