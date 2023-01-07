import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izbakery/page/register_page.dart';
import 'package:izbakery/util/rounded_button.dart';
import 'package:flutter/material.dart';
//code for designing the UI of our text field where the user writes his email

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 187, 111, 53), width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 187, 111, 53), width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
    ));

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _auth = FirebaseAuth.instance;

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Login',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              const SizedBox(height: 20.0),
              SvgPicture.asset(
                'lib/assets/Baker-amico.svg',
                height: 280,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                  )),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Password.')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: Color.fromARGB(255, 139, 65, 8),
                  title: 'Log In',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        AlertDialog alert = AlertDialog(
                          title: Text("Login Berhasil"),
                          content: Container(
                            child: Text("Selamat Anda Berhasil login"),
                          ),
                          actions: [
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () =>
                                  Navigator.pushReplacementNamed(context, 'home_screen'),
                            ),
                          ],
                        );
                        showDialog(
                            context: context, builder: (context) => alert);
                        return;
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  RegistrationScreen()));
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(text: 'Don\'t have an account? ', 
                  children: [
                    TextSpan(
                      text: 'Sign-up',
                      style: TextStyle(color: Color.fromARGB(255, 139, 65, 8)),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
