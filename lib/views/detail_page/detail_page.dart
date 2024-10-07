import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_data_app/utils/globals.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Map<String, TextEditingController>> studentControllers = [];

  @override
  void initState() {
    super.initState();
    if (Globals.allStudentDetail.isEmpty) {
      studentControllers = [
        {
          "name": TextEditingController(),
          "id": TextEditingController(),
          "std": TextEditingController(),
        }
      ];
    } else {
      for (var student in Globals.allStudentDetail) {
        studentControllers.add({
          "name": TextEditingController(text: student["name"]),
          "id": TextEditingController(text: student["id"]),
          "std": TextEditingController(text: student["std"]),
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (var controllers in studentControllers) {
      controllers["name"]!.dispose();
      controllers["id"]!.dispose();
      controllers["std"]!.dispose();
    }
  }

  void saveStudentDetails() {
    Globals.allStudentDetail.clear();
    for (var controllers in studentControllers) {
      if (controllers["name"]!.text.isNotEmpty &&
          controllers["id"]!.text.isNotEmpty &&
          controllers["std"]!.text.isNotEmpty) {
        Globals.allStudentDetail.add({
          "name": controllers["name"]!.text,
          "id": controllers["id"]!.text,
          "std": controllers["std"]!.text,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Student Details",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              letterSpacing: 0.8,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xffE9EDC9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enter student details",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.black54),
                  ),
                  Column(
                    children: List.generate(
                      studentControllers.length,
                      (index) => Column(
                        children: [
                          TextFormField(
                            controller: studentControllers[index]["name"],
                            decoration: const InputDecoration(
                              labelText: 'Student Name',
                            ),
                          ),
                          TextFormField(
                            controller: studentControllers[index]["id"],
                            decoration: const InputDecoration(
                              labelText: 'Student ID',
                            ),
                          ),
                          TextFormField(
                            controller: studentControllers[index]["std"],
                            decoration: const InputDecoration(
                              labelText: 'Student Standard',
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              studentControllers.removeAt(index);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      studentControllers.add({
                        "name": TextEditingController(),
                        "id": TextEditingController(),
                        "std": TextEditingController(),
                      });
                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Student"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      saveStudentDetails();
                      Navigator.pop(context);
                    },
                    child: const Text("Save and Go Back"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
