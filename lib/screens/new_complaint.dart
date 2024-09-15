import 'package:flutter/material.dart';
import 'package:student_grivence/api_service.dart';
import 'package:student_grivence/token_service.dart';

class NewComplaint extends StatefulWidget {
  const NewComplaint({super.key});

  @override
  _NewComplaintState createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  final _complaintNameController = TextEditingController();
  final _complaintTitleController = TextEditingController();
  final _complaintDescriptionController = TextEditingController();
  String? _selectedCategory;
  final ApiService _apiService = ApiService();
  final TokenService _tokenService = TokenService();

  final List<String> _categories = [
    'Teaching',
    'Exams',
    'Library',
    'Washrooms',
    'Finance',
    'Ground'
  ];

  void _submitComplaint() async {
    final complaintName = _complaintNameController.text;
    final complaintTitle = _complaintTitleController.text;
    final complaintDescription = _complaintDescriptionController.text;
    final complaintCategory = _selectedCategory;

    if (complaintName.isEmpty ||
        complaintTitle.isEmpty ||
        complaintDescription.isEmpty ||
        complaintCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all the fields")),
      );
      return;
    }

    final token = await _tokenService.getToken();
    final response = await _apiService.createComplaint(token!, complaintName,
        complaintTitle, complaintDescription, complaintCategory);

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complaint submitted successfully")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit complaint")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Complaint"),
        backgroundColor: Colors.yellow[700], // Yellow AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          // Centering content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _complaintNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  fillColor: Colors.yellow[50], // Yellowish input background
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _complaintTitleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.yellow[50], // Yellowish input background
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _complaintDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  fillColor: Colors.yellow[50], // Yellowish input background
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 4, // Multi-line input for detailed descriptions
              ),
              const SizedBox(height: 16),
              const Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: _selectedCategory,
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                hint: const Text('Select a Category'),
                isExpanded: true, // Expands dropdown to fit the width
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitComplaint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
