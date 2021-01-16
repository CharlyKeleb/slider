import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

void main() {
  debugPrintGestureArenaDiagnostics = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.grey,
          child: SleepPage(),
        ),
      ),
    );
  }
}

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  int initTime;
  int endTime;

  int inBedTime;
  int outBedTime;
  int days = 0;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    setState(() {
      initTime = _generateRandomTime();
      endTime = _generateRandomTime();
      inBedTime = initTime;
      outBedTime = endTime;
    });
  }

  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inBedTime = init;
      outBedTime = end;
      days = laps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text('Flutter Slider'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleCircularSlider(
              300,
              endTime,
              height: 250.0,
              width: 250.0,
              primarySectors: 0,
              secondarySectors: 0,
              baseColor: Colors.white,
              selectionColor: Colors.green,
              handlerColor: Colors.green,
              handlerOutterRadius: 12.0,
              onSelectionChange: _updateLabels,
              showRoundedCapInSelection: true,
              showHandlerOutter: false,
              child: Padding(
                  padding: const EdgeInsets.all(42.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      Text('$outBedTime',
                          style:
                              TextStyle(fontSize: 24.0, color: Colors.white)),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Total: ${_formatDays(days)}',
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  )),
              shouldCountLaps: true,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDays(int days) {
    return days > 0 ? ' ${days * 300 + outBedTime}' : '';
  }

  int _generateRandomTime() => Random().nextInt(288);
}
