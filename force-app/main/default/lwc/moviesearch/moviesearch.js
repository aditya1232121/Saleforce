import { LightningElement } from 'lwc';

export default class Moviesearch extends LightningElement {

selectedType = "" ;
loading = false ;                                           

 get options() {
        return [
            { label: 'None', value: '' },
            { label: 'Movie', value: 'movie' },
            { label: 'Series', value: 'series' },
            { label: 'Episode', value: 'episode' },
        ];
    }

    handleChange(event) {
        this.selectedType = event.detail.value;
        this.loading = true ;
    }
    
}
