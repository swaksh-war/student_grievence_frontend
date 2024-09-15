import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_grivence/api_service.dart';
import 'package:student_grivence/screens/resolve_complaint_page.dart';

class AdminComplaintListPage extends StatefulWidget {
  final String category;
  const AdminComplaintListPage({super.key, required this.category});

  @override
  _AdminComplaintListPageState createState() => _AdminComplaintListPageState();
}

class _AdminComplaintListPageState extends State<AdminComplaintListPage>
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
    final response = await _apiService.getComplaintsByCategoryAdmin(widget.category);

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
        title: Text('${widget.category} Complaints (Admin)'),
        bottom: TabBar(
          controller: _tabController,
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
                _buildComplaintList(unresolvedComplaints, true), // Admin can resolve
                _buildComplaintList(resolvedComplaints, false), // Resolved complaints
              ],
            ),
    );
  }

  Widget _buildComplaintList(
      List<Map<String, dynamic>> complaints, bool canResolve) {
    if (complaints.isEmpty) {
      return const Center(child: Text('No Complaints Found'));
    }
    return ListView.builder(
      itemCount: complaints.length,
      itemBuilder: (context, index) {
        final complaint = complaints[index];
        return ListTile(
          title: Text(complaint['title']),
          subtitle: Text(complaint['description']),
          trailing: canResolve
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResolveComplaintPage(complaint: complaint),
                      ),
                    );
                  },
                  child: const Text('Resolve'),
                )
              : null,
        );
      },
    );
  }
}
