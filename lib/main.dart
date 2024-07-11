import 'package:flutter/material.dart';
import 'package:json_converter/screens/screen_splash.dart';
import 'package:json_converter/utilities/app_text.dart';
import 'package:json_converter/utilities/app_theme.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppText.title,
        theme: AppTheme.set,
        home: const SplashScreen(),
      ),
    );
  }
}
