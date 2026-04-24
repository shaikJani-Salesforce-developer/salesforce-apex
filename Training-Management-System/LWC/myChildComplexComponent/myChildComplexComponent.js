import { LightningElement,api } from 'lwc';

export default class MyChildComplexComponent extends LightningElement {
   //define properties here
  @api contacts 
  @api courses
}