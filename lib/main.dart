import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Unity Demo',
      theme: ThemeData(
        sliderTheme: const SliderThemeData(
            showValueIndicator: ShowValueIndicator.always),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Unity Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late UnityWidgetController _unityWidgetController;
  double sliderValue = 0;
  void _updateSliderValue(double value) {
    setState(() {
      sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: [
            UnityWidget(
              onUnityCreated: onUnityCreated,
              onUnityMessage: onUnityMessage,
            ),
            Positioned(
              bottom: 64,
              left: 16,
              right: 16,
              child: SizedBox(
                height: 64,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Slider(
                    label: sliderValue.round().toString(),
                    min: 0,
                    max: 200,
                    onChanged: (value) => moveCubeFromFlutter('$value'),
                    value: sliderValue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Communcation from Flutter to Unity
  void moveCubeFromFlutter(String speed) {
    _unityWidgetController.postMessage(
      'Cube', //gameObjectName
      'MoveCubeFromFlutter', // methodName
      speed,
    );

    // update slider ui
    _updateSliderValue(double.parse(speed));
  }

  // Communication from Unity to Flutter
  // you should see the message of the deltaTime in the debug logs
  void onUnityMessage(message) {
    debugPrint('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
  }
}
