import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_grivence/api_service.dart';
import 'package:student_grivence/screens/complaint_detail_page.dart';

class ComplaintListPage extends StatefulWidget {
  final String category;
  const ComplaintListPage({super.key, required this.category});

  @override
  _ComplaintListPageState createState() => _ComplaintListPageState();
}

class _ComplaintListPageState extends State<ComplaintListPage>
    with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  List<Map<String, dynamic>> unresolvedComplaints = [];
  List<Map<String, dynamic>> resolvedComplaints = [];

  bool isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchComplaints();
  }

  void _fetchComplaints() async {
    final response = await _apiService.getComplaintsByCategory(widget.category);

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> allComplaints =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));

      setState(() {
        unresolvedComplaints = allComplaints
            .where((complaint) => complaint['status'] == 'Unresolved')
            .toList();
        resolvedComplaints = allComplaints
            .where((complaint) => complaint['status'] == 'Resolved')
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.statusCode}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Complaints'),
        backgroundColor: Colors.orange, // Orange AppBar
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white, // Tab indicator color
          tabs: const [
            Tab(text: 'Unresolved'),
            Tab(text: 'Resolved'),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildComplaintList(unresolvedComplaints),
                _buildComplaintList(resolvedComplaints),
              ],
            ),
    );
  }

  Widget _buildComplaintList(List<Map<String, dynamic>> complaints) {
    if (complaints.isEmpty) {
      return const Center(child: Text('No Complaints Found'));
    }
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        final complaint = complaints[index];
        return Card(
          // Add a card for each complaint
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: Icon(
              complaint['status'] == 'Resolved'
                  ? Icons.check_circle_outline
                  : Icons.error_outline, // Icon for complaint status
              color:
                  complaint['status'] == 'Resolved' ? Colors.green : Colors.red,
            ),
            title: Text(
              complaint['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(complaint['description']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ComplaintDetailPage(complaint: complaint),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
