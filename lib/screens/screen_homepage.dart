import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_converter/utilities/app_color.dart';
import 'package:json_converter/utilities/app_size.dart';

import '../utilities/app_text.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  TextEditingController controller = TextEditingController();

  final _keyJson = GlobalKey<FormState>();
  bool isResult = false;
  String result = "";

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        showDialog(
          context: context,
          builder: (builder) => Dialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            alignment: Alignment.center,
            child: ListView(
              padding: const EdgeInsets.all(15),
              shrinkWrap: true,
              children: [
                const Icon(
                  Icons.logout,
                  size: 50,
                  color: Colors.black,
                ),
                AppSize.gapH20,
                Text(
                  AppText.exitMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                AppSize.gapH20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        height: 50,
                        elevation: 0,
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          AppText.yes,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: AppColor.colorPrimary,
                                  ),
                        ),
                      ),
                    ),
                    AppSize.gapW20,
                    Expanded(
                      child: MaterialButton(
                        height: 50,
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          AppText.no,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AppText.jsonPlayground,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(
              AppText.writeJsonString,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            AppSize.gapH15,

            // input field for json
            Form(
              key: _keyJson,
              child: TextFormField(
                controller: controller,
                style: const TextStyle(
                  color: AppColor.colorPrimary,
                  fontFamily: AppText.fontSemibold,
                  fontSize: 13,
                ),
                minLines: 5,
                maxLines: 20,
                cursorColor: Colors.red,
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      isResult = false;
                    });
                  }
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppText.writeJson;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: AppText.hintJson,
                  hintStyle: const TextStyle(
                    color: Colors.black38,
                    fontSize: 12,
                    fontFamily: AppText.fontRegular,
                  ),
                  errorStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontFamily: AppText.fontRegular,
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.5, color: AppColor.colorPrimary),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: AppColor.colorPrimary),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 0.5, color: AppColor.colorPrimary),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Colors.black54),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.red),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            AppSize.gapH50,

            // submit button
            MaterialButton(
              onPressed: stringToJson,
              height: 50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              color: AppColor.colorPrimary,
              child: Text(
                AppText.convert,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            AppSize.gapH20,

            // result
            Visibility(
              visible: isResult,
              // visible: true,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppColor.colorPrimary,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SelectableText(
                  result,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            AppSize.gapH20,

            // clear button
            MaterialButton(
              onPressed: clearText,
              height: 50,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
                side: const BorderSide(
                  color: AppColor.colorPrimary,
                  width: 1,
                ),
              ),
              // color: AppColor.colorPrimary,
              child: Text(
                AppText.clear,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColor.colorPrimary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void stringToJson() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_keyJson.currentState!.validate()) {
      if (controller.text.isNotEmpty) {
        try {
          String fix = controller.text.replaceAll(r"\", "");
          var jsonObject = jsonDecode(fix);
          setState(() {
            result = const JsonEncoder.withIndent("  ").convert(jsonObject);
            isResult = true;
          });
        } on Exception {
          setState(() {
            isResult = true;
            result = AppText.jsonError;
          });
        }
      }
    }
  }

  void clearText() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    setState(() {
      isResult = false;
      controller.clear();
    });
  }
}
