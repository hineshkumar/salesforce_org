import { LightningElement, api, } from 'lwc';
import {
    FlowNavigationNextEvent
} from 'lightning/flowSupport';

export default class ContactForm extends LightningElement {
    @api firstName;
    @api lastName;
    @api email;
    @api phone;
    @api mailingStreet;
    @api mailingCity;
    @api mailingState;
    @api mailingPostalCode;
    @api mailingCountry;

    

    handleSuccess(event) {
        alert("Successfully Done!")
    }

    connectedCallback() {
        
        setTimeout(() => {
            this.handleNext(); 
        }, 10000); 
    }

    handleNext() {
        const nextNavigationEvent = new FlowNavigationNextEvent();
        this.dispatchEvent(nextNavigationEvent);
    }
}