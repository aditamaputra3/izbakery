import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Selamat Datang',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 50.0),
          SvgPicture.asset(
            'lib/assets/undraw_engineering_team_a7n2.svg',
            height: 200,
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.alternate_email_outlined),
              hintText: 'Username',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.lock_outline_rounded),
              hintText: 'Password',
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () {},
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      )),
    );
  }
}
