import 'dart:io';

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_data_app/utils/globals.dart';
import 'package:student_data_app/utils/my_extension.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showEditDialog(BuildContext context, int index) {
    var student = Globals.allStudentDetail[index];
    TextEditingController nameController =
        TextEditingController(text: student['name']);
    TextEditingController idController =
        TextEditingController(text: student['id']);
    TextEditingController stdController =
        TextEditingController(text: student['std']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Student Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Student Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: "Student ID"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: stdController,
                decoration:
                    const InputDecoration(labelText: "Student Standard"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Globals.allStudentDetail[index] = {
                    'name': nameController.text,
                    'id': idController.text,
                    'std': stdController.text,
                  };
                });
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void showAwesomeSnackbar(BuildContext context, String studentName) {
    var snackBar = SnackBar(
      content: AwesomeSnackbarContent(
        title: 'Student Details Deleted',
        message: '$studentName has been removed from the Data.',
        contentType: ContentType.success,
      ),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(15),
        child: Globals.allStudentDetail.isNotEmpty
            ? ListView.builder(
                itemCount: Globals.allStudentDetail.length,
                itemBuilder: (context, index) {
                  var student = Globals.allStudentDetail[index];
                  return Dismissible(
                    key: Key(student['id'] ?? index.toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      showAwesomeSnackbar(context, student['name']);
                      setState(() {
                        Globals.allStudentDetail.removeAt(index);
                      });
                    },
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(15),
                        title: Text(
                          student['name'] ?? "No Name",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.teal,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.tealAccent.shade100,
                                  foregroundImage: Globals.image != null
                                      ? FileImage(Globals.image!)
                                      : null,
                                  child: IconButton(
                                    onPressed: () async {
                                      final ImagePicker imagePicker =
                                          ImagePicker();
                                      final source =
                                          await showDialog<ImageSource>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ElevatedButton(
                                            child: const Text("Camera"),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(ImageSource.camera);
                                            },
                                          );
                                        },
                                      );
                                      if (source != null) {
                                        final XFile? file = await imagePicker
                                            .pickImage(source: source);
                                      }
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 34,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            12.w,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Text("ID: ${student['id'] ?? 'No ID'}"),
                                Text(
                                    "Standard: ${student['std'] ?? 'No Standard'}"),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.teal),
                          onPressed: () {
                            showEditDialog(context, index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt,
                      size: 100,
                      color: Colors.teal.withOpacity(0.5),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'No student details available.',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tap the "+" button to add new students.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('detail_page').then((_) {
            setState(() {});
          });
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
