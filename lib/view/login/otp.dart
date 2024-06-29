import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/common/extension.dart';
import 'package:food_delivery/view/login/new_password.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../common/globs.dart';
import '../../common/service_call.dart';
import '../../widgets/round_button.dart';

class OTP extends StatefulWidget {
  final String email;

  const OTP({super.key, required this.email});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  // -- Otp pin Controller --
  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String code = "";

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
                "We have sent an OTP to your email.",
                textAlign: TextAlign.center,
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
                "Please check your email ${widget.email}\ncontinue to reset your password.",
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

              SizedBox(
                height: 60,
                child: OtpPinField(
                  key: _otpPinFieldController,
                  autoFillEnable: false,
                  textInputAction: TextInputAction.done,

                  onSubmit: (newCode) {
                    code = newCode;
                    btnSubmit();
                  },
                  onChange: (newCode) {
                    code = newCode;
                  },
                  onCodeChanged: (newCode) {
                    code = newCode;
                  },

                  /// to decorate your Otp_Pin_Field
                  otpPinFieldStyle: OtpPinFieldStyle(
                    /// border color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBorderColor: Colors.transparent,

                    /// border color for active/focused Otp_Pin_Field
                    activeFieldBorderColor: Colors.transparent,

                    /// Background Color for inactive/unfocused Otp_Pin_Field
                    defaultFieldBackgroundColor: TColor.textField,

                    /// Background Color for active/focused Otp_Pin_Field
                    activeFieldBackgroundColor: TColor.textField,

                    /// Background Color for filled field pin box
                    // filledFieldBackgroundColor: Colors.green,

                    /// border Color for filled field pin box
                    // filledFieldBorderColor: Colors.green,
                    //
                    /// gradient border Color for field pin box
                    activeFieldBorderGradient: const LinearGradient(
                        colors: [Colors.black, Colors.redAccent]),
                    filledFieldBorderGradient: const LinearGradient(
                        colors: [Colors.green, Colors.tealAccent]),
                    defaultFieldBorderGradient: const LinearGradient(
                        colors: [Colors.orange, Colors.brown]),
                  ),
                  maxLength: 6,

                  /// no of pin field
                  showCursor: true,

                  /// bool to show cursor in pin field or not
                  cursorColor: Colors.indigo,

                  /// to choose cursor color
                  upperChild: const Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(Icons.flutter_dash_outlined, size: 150),
                      SizedBox(height: 20),
                    ],
                  ),

                  ///bool which manage to show custom keyboard
                  showCustomKeyboard: false,

                  /// Widget which help you to show your own custom keyboard in place if default custom keyboard
                  // customKeyboard: Container(),
                  ///bool which manage to show default OS keyboard
                  // showDefaultKeyboard: true,

                  /// to select cursor width
                  cursorWidth: 3,

                  /// place otp pin field according to yourself
                  mainAxisAlignment: MainAxisAlignment.center,

                  /// predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
                  ///use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
                  otpPinFieldDecoration:
                      OtpPinFieldDecoration.defaultPinBoxDecoration,
                ),
              ),

              SizedBox(
                height: media.height * 0.03,
              ),

              // -- continue button --
              RoundButton(
                onPressed: () {
                  btnSubmit();
                },
                title: "Continue",
              ),

              // -- re-send the code to email --
              TextButton(
                onPressed: () {
                  serviceCallForgetRequest({"email": widget.email});
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Didn't Received? ",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Click Here",
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
  void btnSubmit() {
    if (code.length != 6) {
      mdShowAlert(Globs.appName, MSG.enterCode, () {});
      return;
    }

    endEditing();

    serviceCallForgetVerify({
      "email": widget.email,
      "reset_code": code,
    });
  }

  //TODO: ServiceCall

  void serviceCallForgetVerify(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.svForgotPasswordVerify,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          var payloadObj = responseObj[KKey.payload] as Map? ?? {};
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPassword(nObj: payloadObj)
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

  void serviceCallForgetRequest(Map<String, dynamic> parameter) {
    Globs.showHUD();

    ServiceCall.post(
      parameter,
      SVKey.svForgotPasswordRequest,
      withSuccess: (responseObj) async {
        Globs.hideHUD();
        if (responseObj[KKey.status] == "1") {
          mdShowAlert(Globs.appName, "reset code successfully", () {});
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
