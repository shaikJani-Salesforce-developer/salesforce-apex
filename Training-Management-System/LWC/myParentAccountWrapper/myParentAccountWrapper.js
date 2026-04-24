import { LightningElement } from 'lwc';

export default class MyParentAccountWrapper extends LightningElement {

    accountwrapper = [
        {
            account :{ name : 'Hot Star Tech',industry : 'Technology'},
            contacts: [
                {id :'c1', name : 'Smith'},
                {id :'c2', name : 'Raghav'},
                {id :'c3', name : 'Miller'},

            ]
        },
        {
            account :{ name : 'Australia Tech',industry : 'Banking'},
            contacts: [
                {id :'c4', name : 'David'},
                {id :'c5', name : 'Head'},
                {id :'c6', name : 'Marsh'},

            ]
        },
        {
            account :{ name : 'South Africa Tech',industry : 'Entertainment'},
            contacts: [
                {id :'c7', name : 'Brevis'},
                {id :'c8', name : 'Rickelton'},
                {id :'c9', name : 'Rabada'},

            ]
        },
        {
            account :{ name : 'England Soft tech',industry : 'Technology'},
            contacts: [
                {id :'c10', name : 'Bethel'},
                {id :'c11', name : 'Archer'},
                {id :'c12', name : 'Jacks'},

            ]
        },

    ]
}