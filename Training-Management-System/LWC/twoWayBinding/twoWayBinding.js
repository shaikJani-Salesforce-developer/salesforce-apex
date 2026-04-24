import { LightningElement } from 'lwc';

export default class TwoWayBinding extends LightningElement {

    firstname = 'Sachin Tendulkar';
      age = 45;
      oldname = this.firstname;
      oldage = this.age;

    handleInputNameChange(event){
        this.firstname= event.target.value;
    }
    handleInputAgeChange(event){
        this.age = event.target.value;
    }
    handleClick(event){
        alert('You Have Clicked a Button');
    }
    handleClickNameAge(event){
            const oldname = this.oldname;
            const newname = this.firstname;
            const oldage = this.oldage;
            const newage = this.age;
      alert(`The name is changed from ${oldname} to ${newname} and age is changed from ${oldage} to ${newage}`);
    }
}
