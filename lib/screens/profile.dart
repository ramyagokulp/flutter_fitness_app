
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Logout
  void _logoutUser(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  // Reset password
  void _resetPassword() async {
    if (emailController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
        showToast('Password reset email sent.');
      } catch (e) {
        showToast('Error sending password reset email.');
      }
    } else {
      showToast('Enter your email first.');
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 8,
        color: Colors.white, // Change the background color
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50, // Set an appropriate radius
              backgroundImage: NetworkImage('URL_TO_USER_PROFILE_IMAGE'), // Replace with the user's profile image URL
            ),
            SizedBox(height: 20),
            Text(
              '{email}', // Replace with the user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[300], // Add a subtle divider
              indent: 16,
              endIndent: 16,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the edit profile screen
              },
              child: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent[400],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _logoutUser(context);
              },
              child: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent[400],
              ),
            ),
            ElevatedButton(
              onPressed: _resetPassword,
              child: const Text('Change Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigoAccent[400],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
