import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  static const String id = "main";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: const Column(
        children: [
          GoogleMap(initialCameraPosition: initialCameraPosition);
        ],
      ),
      // body: ElevatedButton(
      //   style: ElevatedButton.styleFrom(
      //     minimumSize: const Size(double.infinity, 50),
      //     backgroundColor: Colors.green,
      //   ),
      //   onPressed: () {
      //     DatabaseReference dbref =
      //         FirebaseDatabase.instance.ref().child("Test");
      //     dbref.set("IsConnected");
      //   },
      //   child: const Text("Login"),
      // ),
    );
  }
}
