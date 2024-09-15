import 'package:flutter/material.dart';

class ComplaintDetailPage extends StatelessWidget {
  final Map<String, dynamic> complaint;
  const ComplaintDetailPage({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Complaint Name : ${complaint['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Title : ${complaint['title']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Status : ${complaint['status']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Description : ${complaint['description']}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
            Text(
              'Resolution: ${complaint['resolution']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text('Category: ${complaint['category']}',
                style: const TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}
