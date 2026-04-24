import { LightningElement } from 'lwc';

export default class ChildLifeCycle extends LightningElement {
    //child life cycle
    constructor(){
       super()
       console.log('constructor :Child')
    }
    connectedCallback() {
       console.log('constructor :Child')
    }

    renderedCallback(){
        console.log('constructor :Child')
    }
    errorCallback(error, stack) {
        console.log('constructor :Child')
    }
}