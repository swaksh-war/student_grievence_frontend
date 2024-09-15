import 'package:flutter/material.dart';
import 'package:student_grivence/screens/admin_category.dart';
import 'package:student_grivence/screens/category_page.dart';
import 'package:student_grivence/screens/event_list_page.dart';
import 'package:student_grivence/screens/new_complaint.dart';
import 'package:student_grivence/screens/new_event.dart';
import 'selection_screen.dart';
import 'login_screen.dart';
import 'screens/student_dashboard.dart';
import 'screens/faculty_dashboard.dart';
import 'screens/admin_dashboard.dart';
import 'student_registration.dart';
import 'screens/profile_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SelectionScreen(),
        '/login': (context) => const LoginScreen(),
        '/student_dashboard': (context) => const StudentDashboard(),
        '/faculty_dashboard': (context) => const FacultyDashboard(),
        '/admin_dashboard': (context) => const AdminDashboard(),
        '/register': (context) => const StudentRegistration(),
        '/new_complaint': (context) => const NewComplaint(),
        '/categories': (context) => CategoryPage(),
        '/new_event': (context) => const NewEvent(),
        '/event': (context) => EventListPage(),
        '/profile': (context) => ProfilePage(),
        '/admin_complaint_category': (context) => AdminCategory(),
      },
    );
  }
}
