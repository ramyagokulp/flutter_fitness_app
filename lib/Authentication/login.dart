import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      User? user = userCredential.user;
      if (user != null) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast('Wrong password provided.');
      } else {
        showToast('Error: ${e.message}');
      }
    }
  }

// void _forgotPassword() async {
//     if (emailController.text.isNotEmpty) {
//       try {
//         await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
//         showToast('Password reset email sent.');
//       } catch (e) {
//         showToast('Error sending password reset email.');
//       }
//     } else {
//       showToast('Enter your email first.');
//     }
//   }


void _forgotPassword() async {
  String email = emailController.text.trim();

  if (email.isNotEmpty) {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showToast('Password reset email sent to $email.');
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
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        //appBar: AppBar(title: Text('Login')),
        child: Column(
          children: [
            SizedBox(height: 50,),
         
            Container(
              child: Image(image: AssetImage('assets/gifs/fit.gif')),
            ),  
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(side: BorderSide(width: 5,color: Colors.white ),borderRadius: BorderRadius.circular(26.0),),
                color: Color.fromARGB(255, 154, 140, 241),
                elevation: 161,
                shadowColor: Colors.black,
                surfaceTintColor: Colors.deepPurple,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: emailController,
                   
                        
                        decoration: InputDecoration(fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Email',labelStyle: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 2,
                            style:BorderStyle.solid),borderRadius: BorderRadius.circular(16.0))),
                      ),
                      SizedBox(height: 12),
                      TextField( 
                        
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: 'Password',  
                        labelStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold) ,
                        focusedBorder: UnderlineInputBorder(
                           borderSide: BorderSide(color: Colors.white)),
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Colors. white,width: 2),
                          borderRadius: BorderRadius.circular(16.0),
                   ),),
                        
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: 60,
                        padding: EdgeInsets.only(right:20,left:20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(shadowColor: Colors.black,primary: Colors.white),
                          onPressed: _loginUser,
                          child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Don\'t have an account? Sign up',
                            style: TextStyle(
                              color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),
                      TextButton(
            onPressed: _forgotPassword,
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
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
