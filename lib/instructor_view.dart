import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllInstructorsData() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('instructor').get();

      List<Map<String, dynamic>> instructorsData = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        instructorsData.add({
          'uid': data['uid'],
          'firstname': data['firstname'],
          'lastname': data['lastname'],
          'experience': data['experience'],
        });
      }

      return instructorsData;
    } catch (e, stackTrace) {
      print('Error fetching instructor data: $e');
      print('Stack Trace: $stackTrace');
      throw Exception('Error fetching instructor data');
    }
  }
}


class AllInstructorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Instructors'),
      ),
      body: FutureBuilder(
        future: FirestoreService().getAllInstructorsData(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return showErrorDialog(context, snapshot.error.toString());
          } else if (!snapshot.hasData || snapshot.data == null) {
            return showErrorDialog(context, 'No instructors found');
          } else {
            List<Map<String, dynamic>> instructorsData = snapshot.data!;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust as needed
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: instructorsData.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> instructorData = instructorsData[index];
                return InstructorBox(
                  firstname: instructorData['firstname'],
                  lastname: instructorData['lastname'],
                  experience: instructorData['experience'],
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget showErrorDialog(BuildContext context, String errorMessage) {
    return AlertDialog(
      title: Text('Error Message'),
      content: Text(errorMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}

class InstructorBox extends StatelessWidget {
  final String firstname;
  final String lastname;
  final String experience;

  InstructorBox({
    required this.firstname,
    required this.lastname,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name: $firstname $lastname'),
          Text('Experience: $experience'),
          // Add other fields as needed
        ],
      ),
    );
  }
}
