import 'dart:async';
import 'package:cab_rider/screens/main_page.dart';
import 'package:cab_rider/screens/registrationpage.dart';
import 'package:cab_rider/widgets/ProgressDialog.dart';
import 'package:cab_rider/widgets/toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../widgets/taxibutton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  //Route
  static const String id = "login";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Input fields variables
  late String email;
  late String password;

  //form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  //Check Internet Connection
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  //Login
  void login() async {
    try {
      //Show Dialogue
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            const ProgressDialog(status: "Logging you in"),
      );

      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        final ref = FirebaseDatabase.instance.ref();
        final snapshot = await ref.child("users/${credential.user!.uid}").get();
        if (snapshot.exists) {
          // Navigator.pushNamedAndRemoveUntil(context, MainPage.id);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(MainPage.id, (route) => false);
        } else {
          ToastWidget(message: 'No data available.');
        }
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        ToastWidget(
          message: "No user found for that email",
        );
      } else if (e.code == 'wrong-password') {
        ToastWidget(message: "Wrong password provided for that user.");
      }
    }
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
                  "Sign In as a Rider",
                  style: TextStyle(fontSize: 25, fontFamily: "Brand-Bold"),
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
                    password = value;
                  },
                  validator: (value) {
                    if (value!.length < 8) {
                      return "Password must be atleast 8 characters";
                    }
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
                      login();
                    }
                  },
                  text: 'LOGIN',
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegistrationPage.id);
                  },
                  child: const Text(
                    "Don't have an account, sign up here",
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

  showDialogBox() {
    showCupertinoDialog<String>(
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
}
