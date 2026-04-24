import { LightningElement,api } from 'lwc';

export default class MyChildSpinner extends LightningElement {
    isPlaying = false;
  @api startAnimation(){
          this.isPlaying = true;
          //simulate a delay before stopping the spinner
          setTimeout(()=>{
            this.isPlaying =false;
          },3000) //spinner disappears after 3 seconds 
    }
}