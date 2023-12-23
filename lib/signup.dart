import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'helper.dart';

void main() {
  runApp(SignUpScreen());
}

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Instructor Sign Up'),
          backgroundColor: Colors.purple,
        ),
        body: InstructorRegister(),
      ),
    );
  }
}

class InstructorRegister extends StatefulWidget {
  @override
  _InstructorRegisterState createState() => _InstructorRegisterState();
}

class _InstructorRegisterState extends State<InstructorRegister> {
  AuthService authService = AuthService();

  DateTime _selectedDate = DateTime.now(); // Initialize with current date

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        authService.licenceExpiry.text = "${_selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register Your Account",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: authService.firstname,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    hintStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: authService.lastname,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                    hintStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: authService.email,
                  decoration: InputDecoration(
                    hintText: "E-Mail",
                    hintStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: authService.experience,
                  decoration: InputDecoration(
                    hintText: "Experience",
                    hintStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: authService.licenceNumber,
                  decoration: InputDecoration(
                    hintText: "Licence Number",
                    hintStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: authService.licenceExpiry,
                  decoration: InputDecoration(
                    hintText: "Licence Expiry",
                    hintStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: authService.password,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.purple,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 70),
                    ),
                  ),
                  onPressed: () {
                    if (authService.email != "" && authService.password != "") {
                      authService.InstructorRegister(context);
                    }
                  },
                  child: Text("Register"),
                ),
                TextButton(
                  onPressed: () {
                    // Implement navigation to login screen here
                    // For example:
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
