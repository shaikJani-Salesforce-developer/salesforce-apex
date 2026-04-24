import { LightningElement ,api } from 'lwc';

export default class MyChildCountryComponent extends LightningElement {
   @api  selectedCountry;

   get cities(){
    if(this.selectedCountry === 'USA'){
        return ['New York','Los Angeles','Chicago'];
    }
    else if(this.selectedCountry === 'India'){
        return['Hyderabad','Mumbai','Kolkata'];
    }
    else if(this.selectedCountry === 'Japan'){
        return ['Tokyo','Yokohama','Hiroshima'];
    }
    else{
        return [];
    }

    
   }
}