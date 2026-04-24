import { LightningElement } from 'lwc';

export default class MyParentCountryComponent extends LightningElement {
    selectCountry = ''

   get countryoptions(){
        return[
           { label: 'India', value: 'India' },
            { label: 'USA', value: 'USA' },
            { label: 'Japan', value: 'Japan' },
        ]
            
   }
            
    
    handleCountryChange(event){
        this.selectCountry = event.detail.value;
    }
}