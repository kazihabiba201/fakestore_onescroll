import 'package:fakestore_onescroll/core/app_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:get/get.dart';
import 'core/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.transparent,
          cursorColor: Colors.orange,
          selectionHandleColor: Colors.orange,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: Colors.orange,
          ),
          iconTheme: IconThemeData(
            color: Colors.orange,
          ),
        ),
        hintColor: Colors.orange,
        shadowColor: Colors.orange,
        focusColor: Colors.orange,
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Colors.orange,
          labelStyle: TextStyle(
            color: Colors.orange,
          ),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          iconColor: Colors.orange,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.orange,
            shadowColor: Colors.orange,
            side: const BorderSide(
              color: Colors.orange,
            ),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
        iconTheme: const IconThemeData(
          color: Colors.orange,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.orange,
        ),
      ),
      themeMode: ThemeMode.light,
      
      initialRoute: '/',
      getPages: routes,
    );
  }
}