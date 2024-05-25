import 'dart:math';
import 'package:flutter/material.dart';
import 'package:seajay_s_application2/screens/enrollment/enrollment_one_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_circleimage.dart';
import '../../widgets/app_bar/appbar_subtitle.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class StudentDataSource extends DataTableSource {
  final List<Student> students;
  final Function(Student) onSelect;

  StudentDataSource({required this.students, required this.onSelect});

  @override
  DataRow getRow(int index) {
    final student = students[index];
    return DataRow(cells: [
      DataCell(Text(student.number)),
      DataCell(
        InkWell(
          onTap: () => onSelect(student),
          child: Container(
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
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => students.length;
  @override
  int get selectedRowCount => 0;
}

class StepDetail {
  final String step;
  final String description;
  final String status;

  StepDetail({required this.step, required this.description, required this.status});
}

class Student {
  final String number;
  final String name;
  final String status;
  final List<StepDetail> steps;

  Student({required this.number, required this.name, required this.status, required this.steps});
}

class EnrollmentTwoScreen extends StatefulWidget {
  final String selectedYearLevel;

  EnrollmentTwoScreen({Key? key, required this.selectedYearLevel}) : super(key: key);

  @override
  _EnrollmentTwoScreenState createState() => _EnrollmentTwoScreenState();
}

class _EnrollmentTwoScreenState extends State<EnrollmentTwoScreen> {
  String searchQuery = "";
  String selectedFilter = "All";
  List<Student> students = [];
  List<Student> filteredStudents = [];
  final Random random = Random();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    students = _generateStudents();
    filteredStudents = students;
  }

  List<Student> _generateStudents() {
    List<String> names = [
      "Dela Cruz, Juan M.",
      "Dela Cruz, Juan Coco Martin M.",
      "Dela Cruz, Juan Karlos M.",
      "Estepan, Estavia Jorge G.",
      "Erwan, Heussaf M.",
      "Egg, Dog H.",
      "Smith, John A.",
      "Doe, Jane B.",
      "Johnson, Michael C.",
      "Williams, Sarah D.",
      "Brown, Chris E.",
      "Jones, Pat F.",
      "Garcia, Maria G.",
      "Martinez, Luis H.",
      "Rodriguez, Ana I.",
      "Hernandez, Miguel J.",
      "Lopez, Laura K.",
      "Gonzalez, Carlos L.",
      "Wilson, Emily M.",
      "Anderson, James N.",
      "Thomas, Robert O.",
      "Taylor, Linda P.",
      "Moore, David Q.",
      "Jackson, Barbara R.",
      "Martin, Richard S.",
      "Lee, Susan T."
    ];

    return List<Student>.generate(names.length, (index) {
      List<StepDetail> steps = [];
      bool allStepsDone = true;
      bool previousStepDone = true;

      for (int stepIndex = 0; stepIndex < 4; stepIndex++) {
        bool isDone = previousStepDone ? random.nextBool() : false;
        if (!isDone) {
          allStepsDone = false;
        }
        steps.add(StepDetail(
          step: "Step ${stepIndex + 1}",
          description: _getStepDescription(stepIndex + 1),
          status: isDone ? "DONE" : "PENDING",
        ));
        previousStepDone = isDone;
      }

      return Student(
        number: "2021-${random.nextInt(90000) + 10000}",
        name: names[index],
        status: allStepsDone ? "Enrolled" : "Not Enrolled",
        steps: steps,
      );
    });
  }


  String _getStepDescription(int step) {
    switch (step) {
      case 1:
        return "View / Enlistment Schedule";
      case 2:
        return "View Assessment";
      case 3:
        return "Register";
      case 4:
        return "View Registration Form";
      default:
        return "";
    }
  }

  void _filterStudents(String query) {
    String sanitizedQuery = query.replaceAll('-', '');
    List<Student> filteredList = students.where((student) {
      String sanitizedNumber = student.number.replaceAll('-', '');
      return sanitizedNumber.toLowerCase().contains(sanitizedQuery.toLowerCase());
    }).toList();

    if (selectedFilter != "All") {
      filteredList = filteredList.where((student) => student.status == selectedFilter).toList();
    }

    setState(() {
      searchQuery = query;
      filteredStudents = filteredList;
    });
  }

  void _sortStudents(bool ascending) {
    filteredStudents.sort((a, b) {
      return ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name);
    });
    setState(() {});
  }

  void _filterByEnrollmentStatus(String status) {
    selectedFilter = status;
    _filterStudents(searchQuery);
  }

  void _showStudentDetails(Student student) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Student Details"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("STUDENT ID: ${student.number}", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("STUDENT NAME: ${student.name}", style: TextStyle(fontWeight: FontWeight.bold)),
              Divider(color: Colors.black),
              ...student.steps.map((step) => _buildStepDetail(step.step, step.description, step.status)).toList(),
              _buildStepDetail("STATUS", "Enrolled?", student.status == "Enrolled" ? "ENROLLED" : "NOT ENROLLED"),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildStepDetail(String step, String description, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(step, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          Text(description, style: TextStyle(color: Colors.black)),
          Text(status, style: TextStyle(color: status == "DONE" ? Colors.green : Colors.redAccent)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentDataSource = StudentDataSource(
      students: filteredStudents,
      onSelect: (student) => _showStudentDetails(student),
    );

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
                  ),
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
                    SizedBox(width: 10.h),
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
                  controller: _scrollController,
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    //scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 12,
                      columns: [
                        DataColumn(label: Text('Number')),
                        DataColumn(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Name'),
                              PopupMenuButton<bool>(
                                onSelected: _sortStudents,
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem<bool>(
                                      value: true,
                                      child: Text("A to Z"),
                                    ),
                                    PopupMenuItem<bool>(
                                      value: false,
                                      child: Text("Z to A"),
                                    ),
                                  ];
                                },
                                icon: Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                        ),
                        DataColumn(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Status'),
                              PopupMenuButton<String>(
                                onSelected: _filterByEnrollmentStatus,
                                itemBuilder: (BuildContext context) {
                                  return ['All', 'Enrolled', 'Not Enrolled']
                                      .map((String choice) {
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Text(choice),
                                    );
                                  }).toList();
                                },
                                icon: Icon(Icons.arrow_drop_down),
                              ),
                            ],
                          ),
                        ),
                      ],
                      rows: filteredStudents.map((student) {
                        return DataRow(cells: [
                          DataCell(Text(student.number)),
                          DataCell(
                            InkWell(
                              onTap: () => _showStudentDetails(student),
                              child: Container(
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
                          ),
                          DataCell(
                            Text(
                              student.status,
                              style: TextStyle(
                                fontSize: 14,
                                color: student.status == "Enrolled"
                                    ? Colors.blue
                                    : Colors.red,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _scrollController.animateTo(
              0.0,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
            );
          },
          child: Icon(Icons.arrow_upward),
          backgroundColor: Color(0XFF006699),
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
