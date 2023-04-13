import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paramor/model/weather_model.dart';
import 'package:paramor/service/api.dart';
import 'package:paramor/views/current_weather.dart';
import 'package:paramor/views/infoday.dart';
import 'package:location/location.dart';

Future<void> main() async {
  await dotenv.load(fileName: "lib/.env");
  String apiKey = dotenv.get('API_KEY');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  Future<void> getData() async {
    data = await client.getCurrentWeather(_controller.text);
  }

  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionStatus;
  late LocationData _locationData;
  String latitude = "";
  String longitude = "";

  Future<dynamic> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) _serviceEnabled = await location.requestService();
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
    }
    _locationData = await location.getLocation();
    return _locationData;
  }

  TextEditingController _controller = TextEditingController();

  void initState() {
    super.initState();
    _controller.text = 'London';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff060720),
        appBar: AppBar(
          backgroundColor: const Color(0xff060720),
          elevation: 0.0,
          title: const Text(
            'Weather Now',
            style: TextStyle(color: Colors.white70),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Hold Up!'),
                    content: Text('As you know, we are an weather app! '
                        'and we need your current location to '
                        'improve our accurence. '),
                    actions: [
                      TextButton(
                        onPressed: () {
                          getLocation().then((value) {
                            print(value);
                          });
                        },
                        child: Text('Accept'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('I dont consent'),
                      )
                    ],
                  ),
                );
              },
              icon: Icon(Icons.add_location_alt)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                width: 310,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: 'Search city',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _controller = _controller;
                          });
                        },
                        icon: const Icon(Icons.search),
                      ),
                      hintStyle: const TextStyle(
                          color: Color(0xff060720), fontSize: 17),
                      contentPadding: const EdgeInsets.all(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (data!.cloud == 'Clear')
                            currentWeather(
                              Icons.wb_sunny_rounded,
                              "${data!.temp}",
                              "${data!.city}",
                            ),
                          if (data!.cloud == 'Clouds')
                            currentWeather(Icons.wb_cloudy_rounded,
                                "${data!.temp}", "${data!.city}"),
                          const SizedBox(
                            height: 70,
                          ),
                          const Text(
                            "Today's info",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 20,
                          ),
                          infoToday('${data!.wind}', '${data!.humidity}',
                              '${data!.pressure}', '${data!.feels}')
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
