class User {
  final String username;
  final String password;
  final String mobileNumber;
  final String email;
  final String department;
  final String year;
  final String userType;

  User({
    required this.username,
    required this.password,
    required this.mobileNumber,
    required this.email,
    required this.department,
    required this.year,
    required this.userType,
  });
}

class Complaint {
  final String name;
  final String description;
  final String title;
  final String category;

  Complaint({
    required this.name,
    required this.description,
    required this.title,
    required this.category,
  });
}

class AuthService {
  final List<User> _users = [
    User(
        username: 'a',
        password: 'a',
        mobileNumber: 'a',
        email: 'a',
        department: 'a',
        year: 'a',
        userType: 'Student')
  ];

  final List<Complaint> _complaints = [];

  Future<bool> registerStudent({
    required String username,
    required String password,
    required String mobileNumber,
    required String email,
    required String department,
    required String year,
  }) async {
    bool userExists =
        _users.any((user) => user.username == username || user.email == email);

    if (!userExists) {
      _users.add(User(
        username: username,
        password: password,
        mobileNumber: mobileNumber,
        email: email,
        department: department,
        year: year,
        userType: 'Student',
      ));
      return true;
    } else {
      return false;
    }
  }

  Future<User?> signInWithUsernameAndPassword(
      String username, String password) async {
    User? user = _users.firstWhere(
      (user) => user.username == username && user.password == password,
      // ignore: cast_from_null_always_fails
      orElse: () => null as User,
    );
    return user;
  }

  Future<void> addComplaint({
    required String name,
    required String description,
    required String title,
    required String category,
  }) async {
    _complaints.add(Complaint(
      name: name,
      description: description,
      title: title,
      category: category,
    ));
  }

  Future<List<Complaint>> getComplaints() async {
    return _complaints;
  }

  Future<List<Complaint>> getComplaintsByCategory(String category) async {
    return _complaints
        .where((complaint) => complaint.category == category)
        .toList();
  }
}
