import { LightningElement } from 'lwc';


export default class RedirectToGoogle extends LightningElement {
    connectedCallback() {
        window.open('https://www.google.com', '_blank');
        window.open('https://wwww.fb.com','_blank')
    }
}