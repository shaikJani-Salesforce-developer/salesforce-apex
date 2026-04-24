import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {
    cars = ['Benz','BMW'];
   get car(){
       return this.cars[0];
    }
    //conditional rendering
    isvisible = false;
    handleClick(){
        this.isvisible = true;
    }
    aremoviesavailable = false;
    selectthebox(event) {
        this.aremoviesavailable = event.target.checked;
    }
    name;
    handleNameInputChange(event){
        this.name = event.target.value;
    }
     get namechange(){
        return this.name === 'Conditional Rendering';
     }
     
}