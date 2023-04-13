class Weather {
  String? city;
  double? temp;
  double? wind;
  int? humidity;
  double? feels;
  int? pressure;
  String? cloud;

  Weather({
    this.city,
    this.temp,
    this.wind,
    this.humidity,
    this.feels,
    this.pressure,
    this.cloud
  });

  Weather.fromJson(Map<String, dynamic> json) {
    city = json['name'];
    temp = json['main']['temp'];
    wind = json['wind']['speed'];
    pressure = json['main']['pressure'];
    humidity = json['main']['humidity'];
    feels = json['main']['feels_like'];
    cloud = json['weather'][0]['main'];
  }
}
