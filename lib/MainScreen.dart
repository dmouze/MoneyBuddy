import 'dart:async';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'BttmNavigationBar.dart';

class MainScreen extends StatefulWidget {


  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BluetoothDevice _device;
  late StreamSubscription<BluetoothState> _stateSubscription;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    super.dispose();
  }

  Future<void> _initBluetooth() async {
    _stateSubscription = FlutterBlue.instance.state.listen((state) {
      setState(() {});
      if (state == BluetoothState.on) {
        _scanForDevices();
      }
    });
  }

  void _scanForDevices() {
    FlutterBlue.instance.scan().listen((scanResult) {
      if (scanResult.device.name == "BLE") {
        setState(() {
          _device = scanResult.device;
        });
        _stopScanning();
      }
    });
  }

  void _stopScanning() {
    FlutterBlue.instance.stopScan();
  }

  Future<void> _connectToDevice() async {

    await _device.connect();
    _discoverServices();
  }

  void _discoverServices() async {
    final logger = Logger();
    List<BluetoothService> services = await _device.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == "0000fff0-0000-1000-8000-00805f9b34fb") {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() ==
              "0000fff0-0000-1000-8000-00805f9b34fb") {
            // Tutaj możesz wykonywać operacje na charakterystyce
            // np. odczytywać dane lub wysyłać komendy
            // Przykład: characteristic.write([1, 2, 3]);

            // Dodaj logi:
            logger.d('Odczytano dane z charakterystyki: ${characteristic.value}');
          }
        }
      }
    }
  }

  //
  // String _formattedTime() {
  //   final milliseconds = _stopwatch.elapsedMilliseconds;
  //   final seconds = milliseconds ~/ 1000;
  //   final remainingMilliseconds = milliseconds % 1000;
  //
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   String threeDigits(int n) => n.toString().padLeft(3, '0');
  //
  //   return '${twoDigits(seconds)}:${threeDigits(remainingMilliseconds)}';
  // }

  @override
  Widget build(BuildContext context) {
    return BttmNavigationBar(
      items: [
        BttmNavigationBarModel(icon: Icons.timer, label: "Ekran Główny"),
        BttmNavigationBarModel(icon: Icons.account_circle, label: "Konto"),
      ],
      screens: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Color(0xff49c4ad),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              padding: EdgeInsets.zero,
                              width: 20,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0x00000000),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            Text(
                              "WEMOS CONTROL",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: 24,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0x00000000),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      onPressed: _connectToDevice,
                      // Zmiana na funkcję łączenia z urządzeniem Bluetooth
                      color: Color(0xffffffff),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                        side: BorderSide(color: Color(0xffffffff), width: 1),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      textColor: Color(0xff000000),
                      height: 40,
                      minWidth: 140,
                      child: Text(
                        'Połącz z "WemosD1"', // Zmiana tekstu przycisku
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                width: 200,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xc1000000), width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    // child: Text(
                    //   // _formattedTime(),
                    //   textAlign: TextAlign.start,
                    //   overflow: TextOverflow.clip,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w700,
                    //     fontStyle: FontStyle.normal,
                    //     fontSize: 24,
                    //     color: Color(0xff000000),
                    //   ),
                    // ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0x00000000),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ],
          ),
        ),
        // Placeholder for the second screen (AccountScreen) if needed
        Container(),
      ],
    );
  }
}
