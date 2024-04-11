import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../enrollment_one_screen/enrollment_one_screen.dart'; // ignore_for_file: must_be_immutable

class EnrollmentPage extends StatefulWidget {
  @override
  _EnrollmentPageState createState() => _EnrollmentPageState();
}

class _EnrollmentPageState extends State<EnrollmentPage> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 40.h,
            top: 65.v,
            right: 40.h,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgPlmSealBorApproved2014,
                height: 242.v,
                width: 259.h,
              ),
              SizedBox(height: 65.v),
              _buildColumnselectcol(context),
              SizedBox(height: 57.v),
              CustomElevatedButton(
                text: "SUBMIT",
                margin: EdgeInsets.symmetric(horizontal: 20.h),
                buttonTextStyle: CustomTextStyles.labelMediumOnPrimaryContainer,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnrollmentOneScreen(selectedCollege: dropdownValue ?? ''),
                    ),
                  ).then((_) {
                    // This will be called when you pop back to this page
                    // You can refresh the state or perform any other action here
                  });
                },
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Enrollment",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildColumnselectcol(BuildContext context) {
    return Column(
      children: [

        Text(
          "SELECT COLLEGE",
          style: theme.textTheme.titleSmall,
        ),
        SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow, width: 3.0),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            // Set to null for an empty default value
            hint: Text("    Select a college"),
            // Displayed when the dropdown is not expanded
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            underline: Container(),
            // Remove the underline
            items: <String>[
              'College of Architecture and Urban Planning',
              'College of Education',
              'College of Engineering and Technology',
              'College of Information System & Technology Management',
              'College of Humanities, Arts, and Social Sciences',
              'College of Nursing',
              'College of Physical Therapy',
              'College of Science',
              'PLM Business School',
              'School of Government',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                  child: Container(
                    padding: EdgeInsets.only(left:10.0),
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  );
            }).toList(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}