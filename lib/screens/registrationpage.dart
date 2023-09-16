import 'dart:async';

import 'package:cab_rider/screens/loginpage.dart';
import 'package:cab_rider/screens/main_page.dart';
import 'package:cab_rider/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/ProgressDialog.dart';
import '../widgets/taxibutton.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = "register";

  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  late String fullName;
  late String phoneNumber;
  late String email;
  late String password;

  void registerUser(context) async {
    try {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) =>
              const ProgressDialog(status: "Registering you..."));
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      DatabaseReference newUserRef = FirebaseDatabase.instance
          .ref()
          .child("users/${credential.user!.uid}");

      Map userMap = {
        "fullname": fullName,
        "email": email,
        "phone": phoneNumber,
      };

      await newUserRef.set(userMap);

      Navigator.of(context)
          .pushNamedAndRemoveUntil(MainPage.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        showToast(context, "The password provided is too weak");
      } else if (e.code == 'email-already-in-use') {
        showToast(context, "The account already exists for that email");
      }
    } catch (e) {
      print(e);
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Check Internet Connection
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 70),
                const Image(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  image: AssetImage(
                    "assets/images/logo.png",
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "Create a Rider's Account",
                  style: TextStyle(fontSize: 25, fontFamily: "Brand-Bold"),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) => (fullName = value),
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Please provide a valid fullname";
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    labelText: "Full name",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    hintText: "Please Enter Full name",
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Email Address Must Not Be Empty';
                    } else if (!isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    labelText: "Email Address",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    hintText: "Please Enter Email Address",
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  validator: (value) {
                    if (value!.length < 10) {
                      return "Please provide a valid phone number";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    labelText: "Phone number",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    hintText: "Please Enter Phone number",
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.length < 8) {
                      return "Password must be atleast 8 characters";
                    }
                  },
                  onChanged: (value) => {
                    password = value,
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 14,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    hintText: "Please Enter Password",
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TaxiButton(
                  onpressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser(context);
                    }
                  },
                  text: 'REGISTER',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginPage.id);
                  },
                  child: const Text(
                    "Already have a RIDER account? Log in",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
