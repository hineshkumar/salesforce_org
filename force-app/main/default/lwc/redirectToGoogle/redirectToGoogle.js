import { LightningElement } from 'lwc';
import {
    FlowNavigationNextEvent,
    FlowNavigationFinishEvent
} from 'lightning/flowSupport';

export default class RedirectToGoogle extends LightningElement {
    connectedCallback() {
        window.open('https://www.google.com', '_blank');
        this.handleFinish();
    }

    handleFinish() {
        const finishNavigationEvent = new FlowNavigationFinishEvent();
        this.dispatchEvent(finishNavigationEvent);
    }
}