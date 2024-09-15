import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';

class ApiService {
  final String baseUrl = "http://192.168.0.145:8000/api/";
  final TokenService _tokenService = TokenService();

  Future<http.Response> getUserProfile() async {
    final token = await _tokenService.getToken();
    final url = Uri.parse('${baseUrl}user/');
    return await http.get(url, headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    });
  }

  Future<http.Response> updateUserProfile(
      Map<String, Object> updatedData) async {
    final token = await _tokenService.getToken();
    final url = Uri.parse('${baseUrl}update/');
    return await http.put(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updatedData),
    );
  }

  Future<http.Response> loginUser(String username, String password) async {
    final url = Uri.parse('${baseUrl}login/');

    return await http.post(url, body: {
      'username': username,
      'password': password,
    });
  }

  Future<http.Response> fetchComplaints() async {
    final token = await _tokenService.getToken();
    final url = Uri.parse('${baseUrl}complaints/');
    return await http.get(url, headers: {
      'Authorization': 'Token $token',
    });
  }

  Future<http.Response> createComplaint(
      String token,
      String complaintName,
      String complaintTitle,
      String complaintDescription,
      String complaintCategory) async {
    final url = Uri.parse('${baseUrl}new_complaint/');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': complaintName,
        'title': complaintTitle,
        'description': complaintDescription,
        'category': complaintCategory,
      }),
    );
    return response;
  }

  Future<http.Response> fetchAllComplaints() async {
    final token = await _tokenService.getToken();
    final url = Uri.parse('${baseUrl}complaints/all/');
    return await http.get(url, headers: {
      'Authorization': 'Token $token',
    });
  }

  Future<http.Response> getComplaintsByCategoryAdmin(String category) async {
    final token = await _tokenService.getToken();
    final url = Uri.parse('${baseUrl}complaints_admin/?category=$category');
    return await http.get(url, headers: {
      'Authorization': 'Token $token',
    });
  }

  Future<http.Response> registerUser(
      {required String username,
      required String password,
      required String email,
      required String mobileNumber,
      required String department,
      required String year,
      required String registration,
      required String userType}) async {
    final url = Uri.parse('${baseUrl}register/');
    return await http.post(
      url,
      body: {
        'username': username,
        'password': password,
        'email': email,
        'phone_number': mobileNumber,
        'department': department,
        'year': year,
        'unique_id': registration,
        'user_type': userType,
      },
    );
  }

  Future<http.Response> getComplaintsByCategory(String category) async {
    final url = Uri.parse('${baseUrl}complaints/?category=$category');
    final token = await _tokenService.getToken();
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
    );
    return response;
  }

  Future<http.Response> resolveComplaint(
      int complaintId, String resolution) async {
    final url = Uri.parse("${baseUrl}complaint/$complaintId/resolve/");
    final token = await _tokenService.getToken();
    return await http.put(url, headers: {
      'Authorization': 'Token $token',
      'Content-Type': 'application/json',
    }, 
    body: jsonEncode(
      {
      'resolution': resolution
      }
    )
    );
  }

  Future<http.Response> createEvent(Map<String, dynamic> eventData) async {
    final url = Uri.parse('${baseUrl}new_event/');
    final token = await _tokenService.getToken();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(eventData),
    );
    return response;
  }

  Future<http.Response> fetchEvents() async {
    final token = await _tokenService.getToken();
    final url = Uri.parse('${baseUrl}events/');
    return await http.get(url, headers: {
      'Authorization': 'Token $token',
    });
  }
}
