// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preference/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}
class _DashboardState extends State<Dashboard> {

  late SharedPreferences Logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    Logindata = await SharedPreferences.getInstance();
    setState(() {
      username = Logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("DashBoard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Hey $username, Welcome To Luminar Technolab',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Logindata.setBool('login', true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Text('Logout'),
            )
          ],
        ),
      ),
    );
  }
}