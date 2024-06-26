public with sharing class currencyController {

    public  currencyController() {
        // Http http = new Http();
        // HttpRequest request = new HttpRequest();
        // request.setEndpoint('https://api.currencyapi.com/v3/latest?apikey=cur_live_8Bi5D9c5wcb9I6lcvmUyWYCcgfwpdrrwhUYBaOGv');
        // request.setMethod('GET');
        // HttpResponse response = http.send(request);

        // if(response.getStatusCode() == 200){

        //  Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        
        // }

    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getCurrencyRate() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.currencyapi.com/v3/latest?apikey=cur_live_8Bi5D9c5wcb9I6lcvmUyWYCcgfwpdrrwhUYBaOGv');
        
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            return results;
        } else {
            String errorMessage = null;

            // Find the error message within the HTML body
            Pattern pattern = Pattern.compile('<p>(.*?)</p>');
            Matcher matcher = pattern.matcher(response.getBody());

            if (matcher.find()) {
                errorMessage = matcher.group(1); // This will capture the content inside the <p> tags
            }
            throw new AuraHandledException('Failed to fetch currency rates  '+ '\nStatus Code ' + response.getStatusCode() + '\nError Message '+ errorMessage);
        }
    }

}