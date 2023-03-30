// ignore_for_file: library_private_types_in_public_api

import 'package:crud_firebase/pages/add_student_page.dart';
import 'package:crud_firebase/pages/list_student_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Flutter FireStore CRUD'),
            ElevatedButton(
              onPressed: () => {
                //This navigator will push me to a new page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddStudentPage(),
                  ),
                )
              },
              // ignore: sort_child_properties_last
              child: const Text('Add', style: TextStyle(fontSize: 20.0)),
              //Colors of the buttons
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            )
          ],
        ),
      ),
      body: const ListStudentPage(),
    );
  }
}
