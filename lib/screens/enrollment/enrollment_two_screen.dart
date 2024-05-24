import 'package:flutter/material.dart';
import 'package:seajay_s_application2/screens/enrollment/enrollment_one_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import 'enrollment_page.dart'; // Ensure this import is correct

class EnrollmentTwoScreen extends StatelessWidget {
  final String selectedYearLevel;

  EnrollmentTwoScreen({Key? key, required this.selectedYearLevel})
      : super(key: key);

  get dropdownValue => null;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 10.h,
            vertical: 10.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center the Column horizontally
              children: [
                Container(
                alignment: Alignment.center, // This centers the Text widget within the Container
                child: Text(
                    "LIST OF $selectedYearLevel STUDENTS".toUpperCase(),
                      style: theme.textTheme.headlineSmall,
                    ),
                ),
              SizedBox(height: 20.v), // Add some space between the title and the search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Search Student Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value) {
                    // Call your search function here
                    // For example: searchStudentNumbers(value);
                  },
                ),
              ),
              SizedBox(height: 20.v), // Add some space between the search bar and the list
              // Here you can add your list of students
              // For demonstration, a placeholder ListView is shown
            ],
          ),
        ),
      ),
    );
  }


              // Expanded(
              //   child: ListView.builder(
              //     itemCount: 10, // Example item count
              //     itemBuilder: (context, index) {
              //       return ListTile(
              //         title: Text("Student $index"), // Example student name
              //       );
              //     },
              //   ),
              // ),

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 58.h,
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              // Assuming dropdownValue is defined and accessible here
              // Navigate to EnrollmentOneScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnrollmentOneScreen(
                    selectedCollege: dropdownValue ?? '',
                  ),
                ),
              );
            },
            child: AppbarLeadingCircleimage(
              imagePath: ImageConstant.imgArrowDown,
              margin: EdgeInsets.only(
                left: 23.h,
                top: 12.v,
                bottom: 10.v,
              ),
            ),
          );
        },
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Enrollment",
      ),
      styleType: Style.bgFill,
    );
  }

}