import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Dashboard")),
      body: Center(
          child: Column(
        children: [
          const Text("Welcome to Admin Dashboard"),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/admin_complaint_category");
            },
            child: const Text("see all complains"),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text("Register new user")),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/new_event");
            },
            child: const Text("Add New Event"),
          )
        ],
      )),
    );
  }
}
