import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/common/extension.dart';
import 'package:food_delivery/view/login/otp.dart';

import '../../common/globs.dart';
import '../../common/service_call.dart';
import '../../widgets/round_button.dart';
import '../../widgets/round_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

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
                "Reset Password",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                  color: TColor.primaryText,
                ),
              ),

              SizedBox(
                height: media.height * 0.01,
              ),

              // -- (Add your details ..) text --
              Text(
                "Please enter your email to receive a \n reset code to create a new password via email.",
                style: TextStyle(
                  fontFamily: "Metropolis",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: TColor.secondaryText,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(
                height: media.height * 0.05,
              ),

              // -- enter your email --
              RoundTextField(
                controller: txtEmail,
                hintText: 'Enter Your Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(
                height: media.height * 0.02,
              ),

              // -- login button --
              RoundButton(
                onPressed: () {
                  btnSubmit();
                },
                title: "Send",
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Action
  void btnSubmit() {
    if (!txtEmail.text.isEmail) {
      mdShowAlert(Globs.appName, MSG.enterEmail, () {});
      return;
    }

    endEditing();

    serviceCallForgetPassword({
      "email": txtEmail.text,
    });
  }

  //TODO: ServiceCall
  void serviceCallForgetPassword(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.svForgotPasswordRequest,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTP(
                email: txtEmail.text,
              ),
            ),
          );
        } else {
          mdShowAlert(Globs.appName,
              responseObj[KKey.message] as String? ?? MSG.fail, () {});
        }
      },
      failure: (err) async {
        Globs.hideHUD();
        mdShowAlert(Globs.appName, err, () {});
        if (kDebugMode) {
          print("Service call failed with error: $err");
        }
      },
    );
  }
}
