import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/pages/UpdateStudentPage.dart';
import 'package:flutter/material.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  ListStudentPageState createState() => ListStudentPageState();
}

class ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  //for deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  //Function written for delte user
  Future<void> deleteUser(id) {
    //print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        //for printing the messgae data deleted
        .then((value) => print('User Data Delelted'))
        //for catching exception of data deleted
        .catchError((error) => print('Failed to Delete user:  $error'));
  }

//this StreamBuilder widget helps us to montior the data in realtime

  @override
  Widget build(BuildContext context) {
//this widget helps us to montior the data in realtime

    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          //Extracting data using Map
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            //for storing data in store docs list
            storedocs.add(a);
            //for each attribute id property will be generated
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  //row 1
                  TableRow(children: [
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        // ignore: prefer_const_constructors
                        child: Center(
                          // ignore: prefer_const_constructors
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        // ignore: prefer_const_constructors
                        child: Center(
                          // ignore: prefer_const_constructors
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.greenAccent,
                        // ignore: prefer_const_constructors
                        child: Center(
                          // ignore: prefer_const_constructors
                          child: Text(
                            'Action',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),

                  //Row 2
                  //This for loop will update till the length of storedocs data inserted
                  for (var i = 0; i < storedocs.length; i++) ...[
                    TableRow(
                      children: [
                        //Inside a table row different table cell
                        TableCell(
                          child: Center(
                            child: Text(storedocs[i]['name'],
                                style: TextStyle(fontSize: 18.0)),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: Text(storedocs[i]['email'],
                                style: TextStyle(fontSize: 15.0)),
                          ),
                        ),

                        // TableCell(
                        //   child: Center(
                        //     child: Text('Action', style: TextStyle(fontSize: 18.0)),
                        //   ),
                        // ),

                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateStudentPage(
                                          id: storedocs[i]['id']),
                                    ),
                                  )
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: () =>
                                    {deleteUser(storedocs[i]['id'])},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // TableCell(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       IconButton(
                        //         onPressed: () => {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) => UpdateStudentPage(),
                        //               ))
                        //         },
                        //         icon: Icon(
                        //           Icons.edit,
                        //           color: Colors.orange,
                        //         ),
                        //       ),
                        //       IconButton(
                        //         onPressed: () => {deleteUser(1)},
                        //         icon: Icon(
                        //           Icons.delete,
                        //           color: Colors.red,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ]
                ],
              ),
            ),
          );
        });
  }
}
