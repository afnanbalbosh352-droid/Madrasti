import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // --- 1. Data Structure (Grades -> Sections -> Students) ---
  final Map<String, Map<String, List<String>>> schoolData = {
    "Grade 10": {
      "Section A": ["Ahmad Ali", "Muna Omar", "Zaid Salem","Areej Moh"],
      "Section B": ["Sami Noor", "Raya Hassan","Batool","Ayman"],
      "Section C": ["Dana", "Tia Omar", "Zina Salem","Mahmoud"],

    },
    "Grade 9": {
      "Section A": ["Omar Khalid", "Layla Ahmad","Asala"],
      "Section B": ["Hamza Adam", "Sara Ahmed", "Yousef Noor"],
     "Section C": ["Ahmad Ali", "Muna Omar", "Zaid Salem"],

    }
  };

  String? selectedGrade;
  String? selectedSection;
  
  // To store attendance status: { "Student Name": true/false }
  Map<String, bool> attendanceStatus = {};

  @override
  void initState() {
    super.initState();
    // Initialize default values
    selectedGrade = schoolData.keys.first;
    selectedSection = schoolData[selectedGrade]!.keys.first;
    _initializeAttendance();
  }

  // --- 2. Initialize or Refresh Student List ---
  void _initializeAttendance() {
    // Reset the map to avoid old data conflicts
    attendanceStatus = {}; 
    List<String> students = schoolData[selectedGrade]![selectedSection]!;
    for (var student in students) {
      attendanceStatus[student] = false; // Default: Absent
    }
  }

  void _submitAttendance() {
    // Logic to send data to Firebase will go here
    print("Attendance Data: $attendanceStatus");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Attendance Submitted Successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Safely get the list of students for the current selection
    List<String> currentStudents = schoolData[selectedGrade]![selectedSection] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Attendance"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Class & Section",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            
            // --- Dropdowns Row ---
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedGrade,
                    decoration: const InputDecoration(
                      labelText: "Grade",
                      border: OutlineInputBorder(),
                    ),
                    items: schoolData.keys.map((g) {
                      return DropdownMenuItem(value: g, child: Text(g));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedGrade = val;
                        selectedSection = schoolData[val]!.keys.first;
                        _initializeAttendance();
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSection,
                    decoration: const InputDecoration(
                      labelText: "Section",
                      border: OutlineInputBorder(),
                    ),
                    items: schoolData[selectedGrade]!.keys.map((s) {
                      return DropdownMenuItem(value: s, child: Text(s));
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedSection = val;
                        _initializeAttendance();
                      });
                    },
                  ),
                ),
              ],
            ),
            
            const Divider(height: 40),

            // --- Students List ---
            Expanded(
              child: currentStudents.isEmpty
                  ? const Center(child: Text("No students found."))
                  : ListView.builder(
                      itemCount: currentStudents.length,
                      itemBuilder: (context, index) {
                        String studentName = currentStudents[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: CheckboxListTile(
                            title: Text(
                              studentName,
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              (attendanceStatus[studentName] ?? false) ? "Present" : "Absent",
                              style: TextStyle(
                                color: (attendanceStatus[studentName] ?? false) ? Colors.green : Colors.red,
                              ),
                            ),
                            secondary: const Icon(Icons.person),
                            value: attendanceStatus[studentName] ?? false,
                            activeColor: Colors.green,
                            onChanged: (bool? value) {
                              setState(() {
                                attendanceStatus[studentName] = value!;
                              });
                            },
                          ),
                        );
                      },
                    ),
            ),

            // --- Submit Button ---
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitAttendance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "Submit Attendance",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}