import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Device Info',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Device Information'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

@override
class _MyHomePageState extends State<MyHomePage> {
  //give variables an intial value
  String deviceModel = 'Unknown';
  String osVersion = 'Unknown';

  void initState() {
    super.initState();
    fetchDeviceInfo();
  }

  //Method created to fetch device's model and OS version using device_info package's plugins
  Future<void> fetchDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Device Model: ${androidInfo.model}');
      print('OS Version: ${androidInfo.version.release}');
      setState(() {
        deviceModel = androidInfo.model;
        osVersion = androidInfo.version.release;
      });
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('DeviceModel: ${iosInfo.utsname.machine}');
      print('OS Version: ${iosInfo.systemVersion}');
      setState(() {
        deviceModel = iosInfo.utsname.machine;
        osVersion = iosInfo.systemVersion;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 24),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Device Model: ',
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontFamily: 'CantoraOne',
                            fontSize: 23,
                          ),
                        ),
                        TextSpan(
                          text: deviceModel,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 25,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'OS Version: ',
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontFamily: 'CantoraOne',
                        fontSize: 23,
                      ),
                    ),
                    TextSpan(
                      text: osVersion,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
