import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/common/extension.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common/service_call.dart';
import 'package:food_delivery/view/login/reset_password.dart';
import 'package:food_delivery/view/login/signup.dart';

import '../../widgets/round_button.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/round_textfield.dart';
import '../onboarding/on_boarding.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

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
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 34,
                  color: TColor.primaryText,
                ),
              ),

              // -- (Add your details ..) text --
              Text(
                "Add your details to login",
                style: TextStyle(
                  fontFamily: "Metropolis",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: TColor.secondaryText,
                ),
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

              // -- enter your password --
              RoundTextField(
                controller: txtPassword,
                hintText: 'Enter Your Password',
                obscureText: false,
              ),

              SizedBox(
                height: media.height * 0.02,
              ),

              // -- login button --
              RoundButton(
                onPressed: () {
                  btnLogin();
                },
                title: "Login",
              ),

              // -- forgot password textButton --
              Padding(
                padding: const EdgeInsets.only(left: 160, bottom: 2),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResetPassword()));
                  },
                  child: Text(
                    "Forgot your password?",
                    style: TextStyle(
                      color: TColor.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: media.height * 0.08,
              ),

              // -- or login with social media --
              Text(
                "Or Login With",
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(
                height: media.height * 0.02,
              ),

              // -- facebook login button --
              RoundIconButton(
                title: 'Login with Facebook',
                icon: 'assets/images/facebook.png',
                color: const Color(0xff367FC0),
                onPressed: () {},
              ),

              SizedBox(
                height: media.height * 0.02,
              ),

              // -- google login button --
              RoundIconButton(
                title: 'Login with Google',
                icon: 'assets/images/google.png',
                color: const Color(0xffDB4B39),
                onPressed: () {},
              ),

              SizedBox(
                height: media.height * 0.05,
              ),

              // -- signUp text button --
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signup()));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "SignUp",
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
  void btnLogin() {
    if (!txtEmail.text.isEmail) {
      mdShowAlert(Globs.appName, MSG.enterEmail, () {});
      return;
    }

    if (txtPassword.text.length < 6) {
      mdShowAlert(Globs.appName, MSG.enterPassword, () {});
      return;
    }

    endEditing();

    serviceCallLogin({
      "email": txtEmail.text,
      "password": txtPassword.text,
      "push_token": ""
    });
  }

  //TODO: ServiceCall
  void serviceCallLogin(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(parameter, SVKey.svLogin,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          Globs.udSet(responseObj[KKey.payload] as Map? ?? {}, Globs.userPayload);
          Globs.udBoolSet(true, Globs.userLogin);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoarding(),
            ),
                (route) => false,
          );
        } else {
          mdShowAlert(Globs.appName, responseObj[KKey.message] as String? ?? MSG.fail, () {});
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
