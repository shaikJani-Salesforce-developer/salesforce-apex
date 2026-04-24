import { LightningElement ,api} from 'lwc';

export default class MyCModal extends LightningElement {
    isModalVisible = false;
  @api  showModal(){
        this.isModalVisible = true;
    }
hideModal(){
    this.isModalVisible =false;
}

}