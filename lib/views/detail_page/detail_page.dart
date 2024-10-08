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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // AppBar height
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Colors.tealAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: AppBar(
              title: const Text(
                "Student Details",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enter Student Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      studentControllers.length,
                      (index) => Column(
                        children: [
                          TextFormField(
                            controller: studentControllers[index]["name"],
                            decoration: const InputDecoration(
                              labelText: 'Student Name',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: studentControllers[index]["id"],
                            decoration: const InputDecoration(
                              labelText: 'Student ID',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: studentControllers[index]["std"],
                            decoration: const InputDecoration(
                              labelText: 'Student Standard',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                  const SizedBox(height: 20),
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
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
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
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      iconColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
