import 'package:flutter/material.dart';
import 'package:student_data_app/utils/globals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Function to show the AlertDialog for editing student details
  void _showEditDialog(BuildContext context, int index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Globals.allStudentDetail.isNotEmpty
            ? ListView.builder(
                itemCount: Globals.allStudentDetail.length,
                itemBuilder: (context, index) {
                  var student = Globals.allStudentDetail[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        student['name'] ?? "No Name",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID: ${student['id'] ?? 'No ID'}"),
                          Text("Standard: ${student['std'] ?? 'No Standard'}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(context, index);
                        },
                      ),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'No student details available. Add some students.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('detail_page').then((_) {
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
