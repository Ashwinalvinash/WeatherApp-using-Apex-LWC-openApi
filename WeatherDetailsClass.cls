public without sharing class WeatherDetailsClass {
    @AuraEnabled
    public static WeatherDetailsWrapper getWeatherDetails(string cityName){
        //EndPoint
        //before this class create new Remote Site Details
        //Weather_Site it should have base url http://api.openweathermap.org
        String apiKey = '41a3b2aab3ba73ebc7e58b7a7f63ab5f';
        string endpoint = 'http://api.openweathermap.org/data/2.5/weather?';
        endpoint = endpoint+'q='+cityName;
        endpoint = endpoint+'&units=metric';
        endpoint = endpoint+'&APPID='+apiKey;
        system.debug('EndPoint '+endpoint);
        
        //weather Callout
        Http http = new http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        system.debug('res '+res);
        
        //weatherDetails
        WeatherDetailsWrapper weatherDetails = new WeatherDetailsWrapper();
        if(res.getStatusCode() == 200){
            Map<String,object> result = (Map<String,object>)JSON.deserializeUntyped(res.getBody());
            weatherDetails.city = string.valueOf(result.get('name'));
            Map<String,object> mainResult = (Map<String,object>)(result.get('main'));
            weatherDetails.temperature = string.valueOf(mainResult.get('temp'));
            weatherDetails.pressure = string.valueOf(mainResult.get('pressure'));
            weatherDetails.humidity = string.valueOf(mainResult.get('humidity'));
            weatherDetails.feelsLike = string.valueOf(mainResult.get('feels_like'));
            weatherDetails.tempMax = string.valueOf(mainResult.get('temp_max'));
            weatherDetails.tempMin = string.valueOf(mainResult.get('temp_min'));
            
            
        }
        return weatherDetails ;
        
    }
    public class WeatherDetailsWrapper{
        @AuraEnabled public string city {get;set;}
        @AuraEnabled public string temperature {get;set;}
        @AuraEnabled public string pressure {get;set;}
        @AuraEnabled public string humidity {get;set;}
        @AuraEnabled public string feelsLike {get;set;}
        @AuraEnabled public string tempMax {get;set;}
        @AuraEnabled public string tempMin {get;set;}
    }
    
}