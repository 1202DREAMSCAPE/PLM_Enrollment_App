import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../screens/enrollment/enrollment_page.dart';

enum BottomBarEnum { Home, Sfe, Enrollment, Admission, Announcement }
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      activeIcon: ImageConstant.imgNavHome,
      title: "Home",
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSfe,
      activeIcon: ImageConstant.imgNavSfe,
      title: "SFE",
      type: BottomBarEnum.Sfe,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavEnrollment,
      activeIcon: ImageConstant.imgNavEnrollment,
      title: "Enrollment",
      type: BottomBarEnum.Enrollment,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavAdmission,
      activeIcon: ImageConstant.imgNavAdmission,
      title: "Admission",
      type: BottomBarEnum.Admission,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavAnnouncement,
      activeIcon: ImageConstant.imgNavAnnouncement,
      title: "Announcement",
      type: BottomBarEnum.Announcement,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67.v,
      decoration: BoxDecoration(
        color: appTheme.lightBlue900,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.h),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.2),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          )
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.latoOnPrimaryContainer.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                )
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 18.adaptSize,
                  width: 18.adaptSize,
                  color: appTheme.amber500,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.latoAmber500.copyWith(
                      color: appTheme.amber500,
                    ),
                  ),
                )
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class BottomMenuModel {
  BottomMenuModel(
      {required this.icon,
      required this.activeIcon,
      this.title,
      required this.type});

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

///Handling route based on bottom click actions
String getCurrentRoute(BottomBarEnum type) {
  switch (type) {
    case BottomBarEnum.Home:
      return "/";
    case BottomBarEnum.Sfe:
      return "/";
    case BottomBarEnum.Enrollment:
      return AppRoutes.enrollmentPage;
    case BottomBarEnum.Admission:
      return "/";
    case BottomBarEnum.Announcement:
      return "/";
    default:
      return "/";
  }
}

///Handling page based on route
Widget getCurrentPage(String currentRoute) {
  switch (currentRoute) {
    case AppRoutes.enrollmentPage:
      return EnrollmentPage();
    default:
      return DefaultWidget();
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
