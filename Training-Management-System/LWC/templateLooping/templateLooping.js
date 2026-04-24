import { LightningElement } from 'lwc';

export default class TemplateLooping extends LightningElement {

    heros = ['Pawan Kalyan', 'Mahesh Babu', 'Allu Arjun', 'NTR', 'Ram Charan']
    //aaray of objects 
    students = [
        {
            id : 1,
            name : 'Sai Raj',
            college : 'Mumbai Junior college'
        },
        {
            id :2,
            name : 'Manoj',
           college : 'Delhi Public School'
        },
        {
            id : 3,
            name : 'Lakshman',
            college : 'Hyderabad Public school'
        },
        {
            id : 4,
            name : 'Rajeev',
            college : 'Chaitanya Public School'
        }
    ]
}