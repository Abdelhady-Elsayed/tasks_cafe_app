import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileTab extends StatefulWidget {
  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> with SingleTickerProviderStateMixin {
  String firstName = '';
  String lastName = '';
  String email = '';
  String job = '';
  String address = '';
  String gender = '';
  List<String> completedTasks = [];

  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _loadData();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('first_name') ?? '';
      lastName = prefs.getString('last_name') ?? '';
      email = prefs.getString('email') ?? '';
      job = prefs.getString('job') ?? '';
      address = prefs.getString('address') ?? '';
      gender = prefs.getString('gender') ?? '';
      completedTasks = aprefs.getStringList('completed_tasks') ?? [];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text("$label: ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Expanded(
              child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeIn,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Account Info",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
            SizedBox(height: 10),
            _buildUserInfoRow("Name", "$firstName $lastName"),
            _buildUserInfoRow("Email", email),
            _buildUserInfoRow("Job", job),
            _buildUserInfoRow("Address", address),
            _buildUserInfoRow("Gender", gender),

            SizedBox(height: 20),
            Divider(),
            Text("Completed Tasks",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown)),
            SizedBox(height: 10),
            completedTasks.isEmpty
                ? Text("No completed tasks yet.")
                : Column(
              children: completedTasks.map((task) {
                return ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text(task,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
