import { LightningElement, track } from 'lwc';

export default class Meradatade extends LightningElement {
    
    @track users = [];

    async clickhogyahai() {
        try {
            const res = await fetch("https://api.github.com/users");
            const data = await res.json();
            this.users = data;
        } catch (error) {
            console.error('Error fetching users:', error);
        }
    }

}
