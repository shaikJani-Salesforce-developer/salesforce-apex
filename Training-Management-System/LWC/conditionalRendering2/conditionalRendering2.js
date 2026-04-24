import { LightningElement } from 'lwc';

export default class ConditionalRendering2 extends LightningElement {

    isChecked = false;
    checked(event){
     this.isChecked= event.target.checked
    }
    handleClick(){
        console.log('Submitted!!');
    }
      username='';
      showMessage = false;
      changeuser(){
       this.username= event.target.value;
      }
      onMesageClick(){
         if(this.username){
            this.showMessage = true;
         }
      }
      temperature = null;
      changeTemperature(event){
         this.temperature= parseFloat(event.target.value);
      }
      get cold(){
        return this.temperature != null && this.temperature <= 15;
      }
      get warm(){
       return this.temperature != null && this.temperature >15 && this.temperature <=15;
      }
      get Hot(){
       return  this.temperature !=null && this.temperature >30;
      }

      //weather check
     weathervalue = '';

    get weatheroptions() {
        return [
            { label: 'Sunny', value: 'Sunny' },
            { label: 'Rainy', value: 'Rainy' },
            { label: 'Cloudy', value: 'Cloudy' },
        ];
    }

    handleChange(event) {
        this.weathervalue = event.detail.value;
    }
    get isSunny(){
       return this.weathervalue === 'Sunny';
    }
    get isRainy(){
      return this.weathervalue === 'Rainy';
    }
    get isCloudy(){
      return this.weathervalue === 'Cloudy';
    }
     password ='';
     rePassword = '';
     message = '';
     messageClass = ''; // for color

     passwordChange(event){
      this.password = event.target.value;
     }
     rePasswordChange(event){
      this.rePassword = event.target.value;
     }
     handleClick(){
      if(this.password ===''|| this.rePassword === ''){
         this.message = 'Enter Password and Re Password Both';
         this.messageClass = 'slds-text-color_error';
      }
      else if(this.password !== this.rePassword){
         this.message = 'Your Password Missmatched';
         this.messageClass = 'slds-text-color_error';
      }
      else{
          this.message ='Password Match';
          this.messageClass = 'slds-text-color_success';
      }
     } 
     
}