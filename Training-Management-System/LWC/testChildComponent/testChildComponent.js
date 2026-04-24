import { LightningElement,api } from 'lwc';

export default class TestChildComponent extends LightningElement {
   @api myname;
   @api myage;
   @api firstname = 'Child First Name';
   @api lastname = 'Child Last Name';
   handlefnChange(event){
    this.firstname= event.target.value
   }
   handlelnChange(event){
    this.lastname = event.target.value 
   }
  @api handleClick(){
       const events = new CustomEvent('salesforce',{
        detail : 
          {
            cname : this.myname,
            cage : this.myage,
            childfirstname : this.firstname,
            childlastname : this.lastname

          }
       })
       this.dispatchEvent(events)
   }
}