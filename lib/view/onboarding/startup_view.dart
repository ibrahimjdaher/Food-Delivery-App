import 'package:flutter/material.dart';


import 'package:food_delivery/view/main_tabview/main_tabview.dart';
import '../../common/globs.dart';
import '../login/welcome_view.dart';



class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    goToWelcomePage();
  }

  void goToWelcomePage() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    welcomePage();
  }

  void welcomePage() {
    if (Globs.udValueBool(Globs.userLogin)) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainTabview()));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // -- background image --
          Image.asset(
            "assets/images/splash_bg.png",
            width: media.width,
            height: media.height,
            fit: BoxFit.cover,
          ),

          // -- logo image --
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: media.width * 0.4,
                height: media.height * 0.4,
              ),
            ),
          ),

          // -- happy meal text --
          const Padding(
            padding: EdgeInsets.only(top: 130),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}
