// ignore_for_file: use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preference/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  late SharedPreferences Logindata;
  late bool Newuser;

  @override
  void initState() {
    super.initState();
    checkifalreadylogin();
  }
  void checkifalreadylogin() async {
    Logindata = await SharedPreferences.getInstance();
    Newuser = (Logindata.getBool('login') ?? true);
    print(Newuser);

    if (Newuser == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Shared Preference"),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text("Login Here",style: TextStyle(fontSize: 25),),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: password_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String username = username_controller.text;
                String password = password_controller.text;
                if (username != '' && password != '') {
                  print('Successful');
                  Logindata.setBool('login', false);
                  Logindata.setString('username', username);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Dashboard()));
                }
              },
              child: const Text("Log-In"),
            ),
          ],
        ),
      ),
    );
  }
}
