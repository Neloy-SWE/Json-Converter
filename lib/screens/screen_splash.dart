import 'dart:async';

import 'package:flutter/material.dart';
import 'package:json_converter/screens/screen_homepage.dart';
import 'package:json_converter/utilities/app_color.dart';
import 'package:json_converter/utilities/app_size.dart';
import 'package:json_converter/utilities/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (builder) => const HomepageScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppText.welcome,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon as a logo
            const Icon(
              Icons.data_object,
              size: 100,
              color: AppColor.colorPrimary,
            ),
            AppSize.gapH50,

            // title
            Text(
              AppText.title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AppSize.gapH20,

            // loader
            const SizedBox(
              height: 15,
              width: 15,
              child: CircularProgressIndicator(
                color: AppColor.colorPrimary,
                strokeWidth: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
