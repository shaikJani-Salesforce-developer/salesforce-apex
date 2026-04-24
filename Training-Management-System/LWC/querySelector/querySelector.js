import { LightningElement } from 'lwc';

export default class QuerySelector extends LightningElement {
     traineeslist = ['Madhav','Noorjahan','Munthaj','Rafi'];
    handleClick(){
       const divtext = this.template.QuerySelector('div');
       console.log(divtext.innertext);

      const trainislist = this.template.QuerySelectorAll('.train');
      Array.from(trainislist).forEach(item=>{
        console.log(item.innertext);
      })

    }
    
}