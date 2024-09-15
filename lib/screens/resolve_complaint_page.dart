import 'package:flutter/material.dart';
import 'package:student_grivence/api_service.dart';

class ResolveComplaintPage extends StatefulWidget {
  final Map<String, dynamic> complaint;
  const ResolveComplaintPage({super.key, required this.complaint});

  @override
  _ResolveComplaintPageState createState() => _ResolveComplaintPageState();
}

class _ResolveComplaintPageState extends State<ResolveComplaintPage> {
  final TextEditingController _resolutionController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  void _resolveComplaint() async {
    setState(() {
      _isLoading = true;
    });

    String resolution = _resolutionController.text;

    if (resolution.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resolution cannot be empty')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final response =
        await _apiService.resolveComplaint(widget.complaint['id'], resolution);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complaint Resolved Successfully')),
      );
      Navigator.pop(context); // Go back to the complaints list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to resolve complaint')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resolve Complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.complaint['title']} - ${widget.complaint['id']}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: ${widget.complaint['description']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Resolution',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _resolutionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Resolution',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    onPressed: _resolveComplaint,
                    child: const Text('Resolve Complaint'),
                  ),
          ],
        ),
      ),
    );
  }
}
