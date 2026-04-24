import { LightningElement,api,track } from 'lwc';

export default class MyChildComponent extends LightningElement {
  @api  name ="JS Child Component"
 @api age 
 @api isVisible
 @track fullname = 'Java Script'
}