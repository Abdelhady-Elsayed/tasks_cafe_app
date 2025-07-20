import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';
class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String? _gender;


  Future<void> _saveAccountInfo() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("first_name", _firstNameController.text.trim());
    await prefs.setString("last_name", _lastNameController.text.trim());
    await prefs.setString("email", _emailController.text.trim());
    await prefs.setString("job", _jobController.text.trim());
    await prefs.setString("address", _addressController.text.trim());
    await prefs.setString("gender", _gender ?? "");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Your Account"),
        backgroundColor: Colors.brown,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(labelText: 'Job Title'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: InputDecoration(labelText: 'Gender'),
              items: ['Male', 'Female'].map((g) {
                return DropdownMenuItem(
                  value: g,
                  child: Text(g),
                );
              }).toList(),
              onChanged: (val) => setState(() => _gender = val),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed:(){
                _saveAccountInfo;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) =>  HomeScreen(),
                ));
                },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
              child: Text(
                'Save Account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

            )
          ],
        ),
      ),
    );
  }
}
