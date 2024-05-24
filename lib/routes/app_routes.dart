import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../screens/enrollment/enrollment_container_screen.dart';
import '../screens/enrollment/enrollment_one_screen.dart';
import '../screens/enrollment/enrollment_two_screen.dart';

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
