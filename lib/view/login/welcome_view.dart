import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/view/login/login.dart';
import 'package:food_delivery/view/login/signup.dart';

import '../../widgets/round_button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // -- welcome top shape design --
                Image.asset(
                  "assets/images/welcome_top_shape.png",
                  width: media.width,
                ),
        
                // -- logo --
                Image.asset(
                  "assets/images/logo.png",
                  width: media.width * 0.3,
                  height: media.height * 0.3,
                  fit: BoxFit.contain,
                ),
        
                // -- happy meal & food delivery texts --
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Happy",
                            style: TextStyle(
                              fontFamily: "Metropolis",
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xffFA6011),
                            ),
                          ),
                          Text(
                            " Meal",
                            style: TextStyle(
                              fontFamily: "Metropolis",
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Food Delivery",
                        style: TextStyle(
                          letterSpacing: 2,
                          fontFamily: "Metropolis",
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
        
            // -- (Discover the best ...) text --
            Text(
              "Discover the best foods from over 1,000\n restaurants & fast delivery to your doorstep.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: media.width * 0.12,
            ),
        
            // -- login button --
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                title: "Login",
              ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
        
            // -- create account button --
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signup()));
                },
                type: RoundButtonType.textPrimary,
                title: "Create an account",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
