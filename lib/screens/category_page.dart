import 'package:flutter/material.dart';
import 'complaint_list_page.dart';

class CategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Teaching', 'icon': Icons.school},
    {'name': 'Exams', 'icon': Icons.assignment},
    {'name': 'Library', 'icon': Icons.library_books},
    {'name': 'Washrooms', 'icon': Icons.bathroom},
    {'name': 'Finance', 'icon': Icons.account_balance_wallet},
    {'name': 'Ground', 'icon': Icons.sports_soccer},
  ];

  CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.orange, // Orange-themed AppBar
      ),
      body: Center(
        // Center the content vertically
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            shrinkWrap: true, // Ensures the list is centered
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Card(
                // Add a card around each list item for styling
                child: ListTile(
                  leading: Icon(categories[index]['icon'],
                      color: Colors.orange), // Orange icons
                  title: Text(
                    categories[index]['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // Bold text
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComplaintListPage(
                            category: categories[index]['name']),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
