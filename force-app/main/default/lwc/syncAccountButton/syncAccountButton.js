import { LightningElement, api } from 'lwc';
import syncAccountToAPI from '@salesforce/apex/AccountAPIService.syncAccountToAPI';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SyncAccountButton extends LightningElement {
    @api recordId;

    handleClick() {
        syncAccountToAPI({ accountId: this.recordId })
        .then(result => {
            this.showToast('Success', 'API Called Successfully', 'success');
            console.log('API Response:', result);
        })
        .catch(error => {
            this.showToast('Error', error.body.message, 'error');
            console.error(error);
        });
    }

    

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title,
                message,
                variant
            })
        );
    }
}



