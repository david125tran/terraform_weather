# terraform_weather  
In this project, I deploy a weather dashboard of Cape Canaveral, Florida using Nodered, Influx, and Grafana via Terraform.  For this project, I followed an online course.  
I use AWS Cloud9 to provision my EC2 and host my instance. And I make an API call to https://openweathermap.org/ to pull the weather.  
I perform my API call to pull the data to Influx and then pull from Influx to Grafana to show my visualization.  
  
I use Nodered to map my infrastructures and perform my API call to get my data to Influx:
![Nodered](https://github.com/david125tran/terraform_weather/blob/master/images/nodered.png)  
  
I set up my weather data bucket with Influx:  
![Influx](https://github.com/david125tran/terraform_weather/blob/master/images/influxdb.png)  
  
I then pull the data from Influx to Grafana:
![Grafana](https://github.com/david125tran/terraform_weather/blob/master/images/grafana.png)  
