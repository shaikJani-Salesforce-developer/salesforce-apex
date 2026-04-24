import { LightningElement } from 'lwc';

export default class TestParentComponent extends LightningElement {
     parentfirstname = ''
     parentlastname = ''
    working(event){
       const pname = event.detail.cname;
      const page=  event.detail.cage;
      this.parentfirstname= event.detail.childfirstname
      this.parentlastname= event.detail.childlastname
        alert('Custom event triggered')
        alert('Name is :'+pname)
        alert('Age is :'+page)
    }
}