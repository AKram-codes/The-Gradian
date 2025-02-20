import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  String name = '';
  String school = '';
  String role = 'Parent';

  void _signup() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (newUser != null) {
        await _firestore.collection('users').doc(newUser.user?.uid).set({
          'name': name,
          'email': email,
          'school': school,
          'role': role,
        });
        if (role == 'Parent') {
          Navigator.pushReplacementNamed(context, '/parent_dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/gradian_dashboard');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Gradian - Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
            TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your email',
                labelText: 'Email',
              ),
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your password',
                labelText: 'Password',
              ),
            ),
            TextField(
              onChanged: (value) {
                school = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter your school name',
                labelText: 'School',
              ),
            ),
            DropdownButton<String>(
              value: role,
              onChanged: (String? newValue) {
                setState(() {
                  role = newValue!;
                });
              },
              items: <String>['Parent', 'Gradian']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _signup,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}