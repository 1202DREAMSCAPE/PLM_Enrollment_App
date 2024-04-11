import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/enrollment_container_screen/enrollment_container_screen.dart';
import '../presentation/enrollment_one_screen/enrollment_one_screen.dart';
import '../presentation/enrollment_two_screen/enrollment_two_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class AppRoutes {
  static const String enrollmentPage = '/enrollment_page';

  static const String enrollmentContainerScreen =
      '/enrollment_container_screen';

  static const String enrollmentOneScreen = '/enrollment_one_screen';

  static const String enrollmentTwoScreen = '/enrollment_two_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    enrollmentContainerScreen: (context) => EnrollmentContainerScreen(),
    enrollmentOneScreen: (context) => EnrollmentOneScreen(selectedCollege: '',),
    enrollmentTwoScreen: (context) => EnrollmentTwoScreen(selectedYearLevel: '',),
    initialRoute: (context) => EnrollmentContainerScreen()
  };
}
