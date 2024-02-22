import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weahter_app/model/weather_response.dart';
import 'package:weahter_app/services/weather_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherAPI client = WeatherAPI();
  Weather? data;
  final String location = "London";

  Future<void> getData() async {
    data = await client.getCurrentWeather(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff9f9f9),
        appBar: AppBar(
          backgroundColor: const Color(0xfff9f9f9),
          elevation: 0,
          title: const Text(
            "Weather App",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  currentWeather(Icons.wb_sunny_rounded,
                      data?.temp.toString() ?? "", data?.cityName ?? ""),
                  60.verticalSpace,
                  Text(
                    "Additional Information",
                    style: TextStyle(
                        fontSize: 24.sp,
                        color: const Color(0xdd212121),
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  20.verticalSpace,
                  additionalInformation(
                      data?.wind.toString() ?? "",
                      data?.humidity.toString() ?? "",
                      data?.pressure.toString() ?? "",
                      data?.feelsLike.toString() ?? "")
                ],
              );
            }
          },
        ));
  }

  Widget currentWeather(IconData icon, String temp, String location) {
    return Center(
      child: Column(
        children: [
          Icon(icon, color: Colors.orange, size: 64.r),
          10.verticalSpace,
          Text(
            temp,
            style: TextStyle(fontSize: 46.sp, color: Colors.black),
          ),
          10.verticalSpace,
          Text(
            location,
            style:
                TextStyle(fontSize: 10.sp, color: Colors.grey.withOpacity(0.8)),
          )
        ],
      ),
    );
  }

  Widget additionalInformation(
      String wind, String humidity, String pressure, String feelsLike) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18).r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Wind",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: Colors.black)),
                  18.verticalSpace,
                  Text("Pressure",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: Colors.black)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(wind,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Colors.black)),
                  18.verticalSpace,
                  Text(pressure,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Colors.black)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Humidity",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: Colors.black)),
                  18.verticalSpace,
                  Text("Feels Like",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          color: Colors.black)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(humidity,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Colors.black)),
                  18.verticalSpace,
                  Text(feelsLike,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Colors.black)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
