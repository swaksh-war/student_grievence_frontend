import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_grivence/api_service.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ApiService _apiService = ApiService();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _phoneNumber = '';
  String _department = '';
  String _id = '';
  String _year = '';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final response = await _apiService.getUserProfile();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _usernameController.text = data['username'] ?? '';
          _emailController.text = data['email'] ?? '';
          _passwordController.text = data['password'] ?? '';
          _phoneNumber = data['phone_number'] ?? '';
          _department = data['department'] ?? '';
          _id = data['unique_id'] ?? '';
          _year = data['year'] ?? '';
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load profile");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> _updateProfile() async {
    final updateData = {
      if (_usernameController.text.isNotEmpty)
        'username': _usernameController.text,
      if (_emailController.text.isNotEmpty) 'email': _emailController.text,
      if (_passwordController.text.isNotEmpty)
        'password': _passwordController.text,
    };
    try {
      final response = await _apiService.updateUserProfile(updateData);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        throw Exception("Failed to update profile");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.orange, // Orange-themed AppBar
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              // Center the content
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center-align the form
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle:
                              TextStyle(color: Colors.orange), // Orange label
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Colors.orange), // Orange label
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        enableSuggestions: false,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Colors.orange), // Orange label
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Phone Number: $_phoneNumber'),
                      const SizedBox(height: 10),
                      Text('Department: $_department'),
                      const SizedBox(height: 10),
                      Text('ID: $_id'),
                      const SizedBox(height: 10),
                      Text('Year: $_year'),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        child: const Text('Update Profile'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange, // Orange button
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
