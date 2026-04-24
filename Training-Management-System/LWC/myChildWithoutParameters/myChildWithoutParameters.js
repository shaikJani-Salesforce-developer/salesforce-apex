import { LightningElement ,api} from 'lwc';

export default class MyChildWithoutParameters extends LightningElement {
   @api  showAlertMessage(){
        alert('iam coming from the child component')
    }
}