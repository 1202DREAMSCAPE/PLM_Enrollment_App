import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'enrollment_two_screen.dart'; // Make sure to import the correct screen

class EnrollmentOneScreen extends StatefulWidget {
  final String selectedCollege;

  EnrollmentOneScreen({Key? key, required this.selectedCollege})
      : super(key: key);

  @override
  _EnrollmentOneScreenState createState() => _EnrollmentOneScreenState();
}

class _EnrollmentOneScreenState extends State<EnrollmentOneScreen> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 22.h,
            top: 70.v,
            right: 22.h,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgPlmSealBorApproved2014,
                height: 164.v,
                width: 165.h,
              ),
              SizedBox(height: 27.v),
              Container(
                width: 305.h,
                child: Text(
                  widget.selectedCollege,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge!.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 50.v),
              _buildColumnyearlevel(context),
              SizedBox(height: 52.v),
              CustomElevatedButton(
                text: "SUBMIT",
                margin: EdgeInsets.symmetric(horizontal: 37.h),
                buttonTextStyle: CustomTextStyles.labelMediumOnPrimaryContainer,
                onPressed: () {
                  if (dropdownValue == null) {
                    _showWarningDialog(context);
                  } else {
                    // Navigate to EnrollmentTwoScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EnrollmentTwoScreen(
                            selectedYearLevel: dropdownValue ?? ''),
                      ),
                    );
                  }
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
      leadingWidth: 58.h,
      leading: AppbarLeadingCircleimage(
        imagePath: ImageConstant.imgArrowDown,
        margin: EdgeInsets.only(
          left: 23.h,
          top: 12.v,
          bottom: 10.v,
        ),
      ),
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Enrollment",
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildColumnyearlevel(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Column(
        children: [
          Text(
            "YEAR LEVEL",
            style: theme.textTheme.titleSmall,
          ),
          SizedBox(height: 13.v),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.yellow, width: 3.0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: dropdownValue,
              hint: Text("    Select Year Level"),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              underline: Container(),
              items: <String>[
                '1st Year',
                '2nd Year',
                '3rd Year',
                '4th Year',
                '5th Year',
                '6th Year'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
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
      ),
    );
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Warning"),
          content: Text("Please select a year level before submitting."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
