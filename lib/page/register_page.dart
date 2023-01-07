import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izbakery/page/login_page.dart';
import 'package:izbakery/util/rounded_button.dart';
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


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
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
                'Register',
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
                    //Do something with the user input.
                  },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.left,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                 decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Password.')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                colour: Color.fromARGB(255, 139, 65, 8),
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, 'home_screen');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                },
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(text: 'Have an account? ', 
                  children: [
                    TextSpan(
                      text: 'Login',
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
