public class WeatherApiGet {
    public String selectedCity{get;set;}
    public List<WeatherResponse> weatherWrapperList{get;set;}
    
    public void getWeatherDetailsContent(){
        //new http obj
        Http httpObj = new Http();
        weatherWrapperList = new List<WeatherResponse>();
        //new http request
        //Mention request properties such as endpoint, postmethod etc.
        HttpRequest reqObj = new HttpRequest();
        String cityName = selectedCity;
        String Api_Key = '3a296982ee0fcb46318eae571be98c64';
        String url = 'https://api.openweathermap.org/data/2.5/weather?q='+cityName+'&appid='+Api_Key;
        reqObj.setEndpoint(url);
        reqObj.setMethod('GET');
        
        // Send the request, and return a response
        HttpResponse response = httpObj.send(reqObj);
        System.debug('Response ::'+ response);
        if(response.getStatusCode() == 200){
            WeatherResponse wthrRes = (WeatherResponse) Json.deserialize(response.getBody(), WeatherResponse.class);
            System.debug('Name:'+wthrRes.name);
            System.debug('Country:'+wthrRes.sys.country);
            System.debug('Sunrise:'+wthrRes.sys.sunrise);
            System.debug('Sunset:'+wthrRes.sys.sunset);
            System.debug('Description:'+wthrRes.weather[0].description);
            System.debug('Temprature:'+wthrRes.main.temp);
            System.debug('Feels Like:'+wthrRes.main.feels_like);
            System.debug('Pressure:'+wthrRes.main.pressure);
            System.debug('Humidity:'+wthrRes.main.humidity);
            weatherWrapperList.add(wthrRes);
            system.debug('weatherWrapperList'+weatherWrapperList); 
        }
        else if(response.getStatusCode() == 401){
            System.Debug('Unauthorized Access');
        }
        
    }
    
    public class WeatherResponse {
        public String name{get;set;}
        public String timezone{get;set;}
        public Integer visibility{get;set;}
        public SysData sys{get;set;}
        public List<WeatherData> weather{get;set;}
        public MainTemperature main{get;set;}
    }
    
    public class SysData {
        public String country{get;set;} 
        public Integer sunrise{get;set;}
        public Integer sunset{get;set;}
    } 
    
    public class WeatherData {
        public String description{get;set;} 
    } 
    
    public class MainTemperature {
        public Decimal temp{get;set;}
        public Decimal feels_like{get;set;}
        public Decimal temp_min{get;set;}
        public Decimal temp_max{get;set;}
        public Integer pressure{get;set;}
        public Integer humidity{get;set;}
    }
}