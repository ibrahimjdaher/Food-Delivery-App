import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/common/extension.dart';
import '../../common/globs.dart';
import '../../common/service_call.dart';
import '../../widgets/round_button.dart';
import '../../widgets/round_textfield.dart';
import '../onboarding/on_boarding.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtMobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),

              // -- login text --
              Text(
                "SignUp",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                  color: TColor.primaryText,
                ),
              ),

              // -- (Add your details ..) text --
              Text(
                "Add your details to sign up",
                style: TextStyle(
                  fontFamily: "Metropolis",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: TColor.secondaryText,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // -- enter your name --
              RoundTextField(
                controller: txtName,
                hintText: 'Enter Your First Name',
                obscureText: false,
              ),
              const SizedBox(
                height: 25,
              ),

              // -- enter your email --
              RoundTextField(
                controller: txtEmail,
                hintText: 'Enter Your Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(
                height: 25,
              ),

              // -- enter your password --
              RoundTextField(
                controller: txtPassword,
                hintText: 'Enter Your Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),

              // -- confirm your password --
              RoundTextField(
                controller: txtConfirmPassword,
                hintText: 'Re-Enter Your Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 25,
              ),

              // -- enter your phoneNumber --
              RoundTextField(
                controller: txtMobile,
                hintText: 'Enter Your PhoneNumber',
                obscureText: false,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 25,
              ),

              // -- enter your address --
              RoundTextField(
                controller: txtAddress,
                hintText: 'Enter Your Address',
                obscureText: false,
              ),

              const SizedBox(
                height: 25,
              ),

              // -- signup button --
              RoundButton(
                onPressed: () {
                  btnSignUp();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const OTP()));
                },
                title: "Signup",
              ),

              const SizedBox(
                height: 25,
              ),

              // -- signUp text button --
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: TColor.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Action
  void btnSignUp() {
    if (txtName.text.isEmpty) {
      mdShowAlert(Globs.appName, MSG.enterName, () {});
      return;
    }
    if (txtMobile.text.isEmpty) {
      mdShowAlert(Globs.appName, MSG.enterMobile, () {});
      return;
    }
    if (txtAddress.text.isEmpty) {
      mdShowAlert(Globs.appName, MSG.enterAddress, () {});
      return;
    }
    if (!txtEmail.text.isEmail) {
      mdShowAlert(Globs.appName, MSG.enterEmail, () {});
      return;
    }

    if (txtPassword.text.length < 6) {
      mdShowAlert(Globs.appName, MSG.enterPassword, () {});
      return;
    }
    if (txtPassword.text != txtConfirmPassword.text) {
      mdShowAlert(Globs.appName, MSG.enterPasswordNotMatch, () {});
      return;
    }

    endEditing();

    serviceCallSignUp({
      "email": txtEmail.text,
      "password": txtPassword.text,
      "name": txtName.text,
      "mobile": txtMobile.text,
      "address": txtAddress.text,
      "push_token": "",
      "device_type": Platform.isAndroid ? "A" : "I",
    });
  }

  //TODO: ServiceCall
  void serviceCallSignUp(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.svSignUp,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          Globs.udSet(
              responseObj[KKey.payload] as Map? ?? {}, Globs.userPayload);
          Globs.udBoolSet(true, Globs.userLogin);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoarding(),
            ),
            (route) => false,
          );
        } else {
          mdShowAlert(Globs.appName,
              responseObj[KKey.message] as String? ?? MSG.fail, () {});
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        String errorMessage = err.toString();
        mdShowAlert(Globs.appName, errorMessage, () {});
        if (kDebugMode) {
          print("Service call failed with error: $errorMessage");
        }
      },
    );
  }
}
