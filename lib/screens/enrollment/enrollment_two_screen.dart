import 'package:flutter/material.dart';
import 'package:seajay_s_application2/screens/enrollment/enrollment_one_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class Student {
  final String number;
  final String name;
  final String status;

  Student({required this.number, required this.name, required this.status});
}

class EnrollmentTwoScreen extends StatefulWidget {
  final String selectedYearLevel;

  EnrollmentTwoScreen({Key? key, required this.selectedYearLevel}) : super(key: key);

  @override
  _EnrollmentTwoScreenState createState() => _EnrollmentTwoScreenState();
}

class _EnrollmentTwoScreenState extends State<EnrollmentTwoScreen> {
  String searchQuery = "";
  List<Student> students = [
    Student(number: "2021-10928", name: "Dela Cruz, Juan M.", status: "Enrolled"),
    Student(number: "2021-99999", name: "Dela Cruz, Juan Coco Martin M.", status: "Not Enrolled"),
    Student(number: "2020-23019", name: "Dela Cruz, Juan Karlos M.", status: "Enrolled"),
    Student(number: "2021-10928", name: "Estepan, Estavia Jorge G.", status: "Enrolled"),
    Student(number: "2021-99999", name: "Erwan, Heussaf M.", status: "Not Enrolled"),
    Student(number: "2019-23019", name: "Egg, Dog H.", status: "Enrolled"),
  ];

  List<Student> filteredStudents = [];

  @override
  void initState() {
    super.initState();
    filteredStudents = students;
  }

  void _filterStudents(String query) {
    String sanitizedQuery = query.replaceAll('-', '');
    List<Student> filteredList = students.where((student) {
      String sanitizedNumber = student.number.replaceAll('-', '');
      return sanitizedNumber.toLowerCase().contains(sanitizedQuery.toLowerCase());
    }).toList();
    setState(() {
      searchQuery = query;
      filteredStudents = filteredList;
    });
  }


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
                padding: EdgeInsets.only(top: 10), // Add padding on top and bottom
                alignment: Alignment.center, // This centers the Text widget within the Container
                child: Text(
                  "LIST OF ${widget.selectedYearLevel} STUDENTS".toUpperCase(),
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF006699),
                      )
                ),
              ),
              SizedBox(height: 20.v), // Add some space between the title and the search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0), // Add padding on the sides
                child: Row(
                  children: [
                    Text(
                      "STUDENT ID:",
                       style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(width: 10.h), // Adjust spacing as needed
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: _filterStudents,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.v), // Add some space between the search bar and the list
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 12,
                      columns: [
                        DataColumn(label: Text('Number')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Status')),
                      ],
                      rows: filteredStudents.map((student) {
                        return DataRow(cells: [
                          DataCell(Text(student.number)),
                          DataCell(
                            Container(
                              width: 150.0, // Adjust the width as needed
                              child: Text(
                                student.name,
                                style: TextStyle(fontSize: 14, height: 1.2),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                maxLines: 3,

                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              student.status,
                              style: TextStyle(
                                fontSize: 14,
                                color: student.status == "Enrolled" ? Colors.blue : Colors.red,
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 58.h,
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
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

  get dropdownValue => null;
}
