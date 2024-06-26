import { LightningElement, wire, track } from 'lwc';
import getCurrencyRate from '@salesforce/apex/currencyController.getCurrencyRate';

export default class CurrencyConverter extends LightningElement {
    @track currencyRates;
    @track error;
    @track currencyError;
    @track amount = 1;
    @track fromCurrency = 'USD';
    @track toCurrency = 'EUR';
    @track convertedAmount;

    @wire(getCurrencyRate)
    wiredCurrencyRate({ error, data }) {
        if (data) {
            this.currencyRates = data;
            this.convertCurrency();
        } else if (error) {
            this.error = error.body ? error.body.message : "Failed to fetch Record";
            console.log("ERROR---------------->",error);
        }
    }

    get currencyOptions() {
        return this.currencyRates ? Object.keys(this.currencyRates.data).map(code => ({ label: code, value: code })) : [];
    }

    handleAmountChange(event) {
        this.amount = event.target.value;
        this.convertCurrency();
    }

    handleFromCurrencyChange(event) {
        this.fromCurrency = event.target.value;
        this.convertCurrency();
    }

    handleToCurrencyChange(event) {
        this.toCurrency = event.target.value;
        this.convertCurrency();
    }

    convertCurrency() {
        if (this.currencyRates && this.fromCurrency && this.toCurrency) {
            let rate = this.currencyRates.data[this.fromCurrency].value;
            let toRate = this.currencyRates.data[this.toCurrency].value;
            this.convertedAmount = (this.amount * toRate) / rate;
        }
    }
}
