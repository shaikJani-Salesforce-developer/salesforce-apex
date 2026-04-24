import { LightningElement } from 'lwc';

export default class OneWayAndTwoWayDataBinding extends LightningElement {
     name = 'Jyothi'
     age = 25;
      handleNameInputChange(event){
         this.name = event.target.value;
      }
      handleAgeInputChange(event){
        this.age = event.target.value;
      }
    firstnumber = 30;
    secondnumber = 20;

}