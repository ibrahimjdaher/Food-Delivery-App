import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/common/extension.dart';
import 'package:food_delivery/view/login/login.dart';
import '../../common/globs.dart';
import '../../common/service_call.dart';
import '../../widgets/round_button.dart';
import '../../widgets/round_textfield.dart';

class NewPassword extends StatefulWidget {
  final Map nObj;

  const NewPassword({super.key, required this.nObj});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

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
                "New Password",
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
                "Please enter your new password.",
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

              // -- enter your new password --
              RoundTextField(
                controller: txtPassword,
                hintText: 'Enter New Password',
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(
                height: media.height * 0.02,
              ),
              // -- enter your new password --
              RoundTextField(
                controller: txtConfirmPassword,
                hintText: 'Re-Enter New Password',
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(
                height: media.height * 0.02,
              ),

              // -- Continue button --
              RoundButton(
                onPressed: () {
                  btnSubmit();
                },
                title: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }

  //TODO: Action
  void btnSubmit() {
    if (txtPassword.text.length < 6) {
      mdShowAlert(Globs.appName, MSG.enterPassword, () {});
      return;
    }

    if (txtPassword.text != txtConfirmPassword.text) {
      mdShowAlert(Globs.appName, MSG.enterPasswordNotMatch, () {});
      return;
    }

    endEditing();

    serviceCallForgetSetNew({
      "user_id": widget.nObj[KKey.userId].toString(),
      "reset_code": widget.nObj[KKey.resetCode].toString(),
      "new_password": txtPassword.text
    });
  }

  //TODO: ServiceCall

  void serviceCallForgetSetNew(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.svForgotPasswordSetNew,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(Globs.appName,
              responseObj[KKey.message] as String? ?? MSG.success, () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false);
          });
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
