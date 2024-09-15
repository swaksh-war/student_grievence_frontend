import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select User Type"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        color: Colors.yellow[100],
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!isLoggedIn) ...[
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login', arguments: 'Student');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[800],
                    textStyle: const TextStyle(fontSize: 18),
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text("Login as Student"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login', arguments: 'Faculty');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[800],
                    textStyle: const TextStyle(fontSize: 18),
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text("Login as Faculty"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login', arguments: 'Admin');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow[800],
                    textStyle: const TextStyle(fontSize: 18),
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text("Login as Admin"),
                ),
                const SizedBox(height: 16),
                
              ],
              if (isLoggedIn)
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    textStyle: const TextStyle(fontSize: 18),
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text("Logout"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
