import { LightningElement } from 'lwc';

export default class MyParentComplexComponent extends LightningElement {

    //create the data for the contacts that is given in the child js 
    contactlist =[
        {id :1 ,name: 'Rohith', email: 'rohith@gmail.com'},
         {id :2 ,name: 'Raju', email: 'raju@gmail.com'},
          {id :3 ,name: 'Miller', email: 'Miller@gmail.com'},
           {id :4 ,name: 'Brevis', email: 'brevis@gmail.com'}
    ]

     
    courselist = [
        {
            courseid : 1,
            nameofthecourse : 'Admin',
            students : [
                {id : 1, nameofthestudent : "Mani"},
                {id : 2, nameofthestudent : "Jyothi"},
                {id : 3, nameofthestudent : "Sravani"}
            ]
        },
        {
           courseid : 2,
            nameofthecourse : 'Apex',
            students : [
                {id : 1, nameofthestudent : "Roja"},
                {id : 2, nameofthestudent : "Ram"},
                {id : 3, nameofthestudent : "Rani"}
            ] 
        }
    ]
}