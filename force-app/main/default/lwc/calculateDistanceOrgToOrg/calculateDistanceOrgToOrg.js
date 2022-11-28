import { LightningElement } from 'lwc';
import getCalculatedDistance from '@salesforce/apex/CalculateDistanceOrgToOrg.getCalculatedDistance';
export default class CalculateDistanceOrgToOrg extends LightningElement {

    cityName1;
    cityName2;
    timeInHours;
    timeInMinutes;
    speed;
    totalTime;
    responseBody;
    handleChange(event) {
        if (event.target.name == 'Cname1') {
            this.cityName1 = event.target.value;
        }
        if (event.target.name == 'Cname2') {
            this.cityName2 = event.target.value;
        }
    }

    handleClick() {
        getCalculatedDistance({ city1: this.cityName1, city2: this.cityName2 })
            .then(result => {
                this.responseBody = result;
                this.calculateTime();
            })
            .catch(error => {
                this.error = error;
            });

    }

    handelCLickCar() {
        this.speed = 60;
        this.handleClick();
    }

    handelCLickTrain() {
        this.speed = 90;
        this.handleClick();
    }

    handelCLickWalk() {
        this.speed = 10;
        this.handleClick();

    }

    handelCLickBike() {
        this.speed = 20;
       this.handleClick();
    }

    handelCLickPlane() {
        this.speed = 500;
        this.handleClick();
    }

    calculateTime() {
        this.timeInHours = Math.floor(this.responseBody/(this.speed)); 
          this.timeInMinutes = Math.floor((this.responseBody/(this.speed) - 
                              Math.floor(this.responseBody/(this.speed)))*60)
        this.totalTime = parseInt(this.timeInHours) + parseInt(this.timeInMinutes);
        }
}