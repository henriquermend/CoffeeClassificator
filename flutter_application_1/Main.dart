import 'dart:html';

import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_screen.dart';
import 'views/splash_screen.dart';
import 'services/api_service.dart';
import 'utils/app_theme.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidegt {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      provider: [
        Provider<ApiService>(
          create: (_) => APiService(),
        ),
      ],
      child: MaterialApp(
        title: 'Classificação do Café',
        theme: appTheme(),

        home: SplashScreen();
      ),
    ); 
 }
}

class HomeScreen extend StatelessWidegt {
  @override
  Widget build(BuildContext context) { 
     return Scaffold(
      appBar: Appbar(
        title: Text("Welcome to Coffee Classifier"), 
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
  Navigator.pushNamed(context, '/coffeePokedex');          
          },
          child: Text("Eplore Coffee"),
        ),
      ),
     );
  }
}

void loadModel() async {
  String res = await
  Tflite.loadModel(
    model: "assets/model.tflite",
    labels: "assets/labels.txt", //colocar um arquivo de labels
  );
   print(res);
}

void classifyImage(String imagePath)
async {
  var recognitions = await
  Tflite.runModelOnImage(
    path: imagePath,
    numresults: 5,
    );
    print(recognitions);
}
