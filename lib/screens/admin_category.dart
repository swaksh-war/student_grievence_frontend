import 'package:flutter/material.dart';
import 'admin_complaint_list_page.dart';

class AdminCategory extends StatelessWidget {
  final List<String> categories = [
    'Teaching',
    'Exams',
    'Library',
    'Washrooms',
    'Finance',
    'Ground',
  ];

  AdminCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(categories[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AdminComplaintListPage(category: categories[index]),
                  ),
                );
              },
            );
          },
        ));
  }
}
