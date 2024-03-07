import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Welcome to landing Page"),
            ElevatedButton(onPressed: (){}, child: Text("Register")),
            ElevatedButton(onPressed: (){}, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
