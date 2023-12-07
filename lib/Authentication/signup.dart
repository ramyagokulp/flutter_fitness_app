import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _registerUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      User? user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast('The account already exists for that email.');
      } else {
        showToast('Error: ${e.message}');
      }
    }
  }

  void showToast(String message) {
    // Same showToast() method as used in login_page.dart
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //appBar: AppBar(title: Text('Sign Up')),
      child: SingleChildScrollView(
        child: Column(   
          children: [
            SizedBox(height:30),
            Container(
              child: Image(image: AssetImage('assets/gifs/veggies.gif')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card( 
                elevation: 61,
                shadowColor: Colors.red,
                surfaceTintColor: Colors.black,
                color: Color.fromARGB(255, 248, 178, 156),
                shape: RoundedRectangleBorder(side: BorderSide(width: 5,color: Colors.white),borderRadius: BorderRadius.circular(26.0),),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.circular(16.0)
                        )),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                      ,
                      ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        padding: EdgeInsets.only(right: 20,left: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shadowColor: Colors.white,primary: Colors.white),
                          onPressed: _registerUser,
                          child: Text('Sign Up',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: Text(
                            'Already have an account? Log in',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
