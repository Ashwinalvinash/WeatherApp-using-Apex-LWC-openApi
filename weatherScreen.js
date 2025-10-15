import { LightningElement} from 'lwc';
import getWeatherDetails from '@salesforce/apex/WeatherDetailsClass.getWeatherDetails';

export default class WeatherScreen extends LightningElement {
    inputCityName = '';
    weatherDetails = {};
    show = false;
    handleInputChange(event){
        this.inputCityName = event.detail.value;

    }
    handleWeatherDetails(){
        getWeatherDetails({cityName : this.inputCityName}).then((result)=>{
            this.show = true;
            this.weatherDetails = result;
            console.log('Result '+ result);


        }).catch((error)=>{
            this.show = false ;
            console.log('Error');
        });
    }
}