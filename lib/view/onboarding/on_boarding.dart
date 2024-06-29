import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/view/main_tabview/main_tabview.dart';
import 'package:food_delivery/widgets/round_button.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController controller = PageController();
  int selectPage = 0;

  List pageArray = [
    {
      "title": "Find Food You Love",
      "subtitle":
          "Discover the best foods from over 1,000\nrestaurants and fast delivery to your\ndoorstep",
      "image": "assets/animation/find_food.gif",
    },
    {
      "title": "Fast Delivery",
      "subtitle": "Fast food delivery to your home, office\n wherever you are",
      "image": "assets/animation/fast_delivery.gif",
    },
    {
      "title": "Live Tracking",
      "subtitle":
          "Real time tracking of your food on the app\nonce you placed the order",
      "image": "assets/animation/live_tracking.gif",
    }
  ];

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        selectPage = controller.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // -- image, title & subtitle --
          PageView.builder(
              controller: controller,
              itemCount: pageArray.length,
              itemBuilder: (context, index) {
                var pageObject = pageArray[index] as Map? ?? {};
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // -- image view --
                    Container(
                      width: media.width,
                      height: media.width,
                      alignment: Alignment.center,
                      child: Image.asset(
                        pageObject["image"].toString(),
                        width: media.width * 0.85,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.05,
                    ),

                    // -- title text --
                    Text(
                      pageObject["title"].toString(),
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.03,
                    ),

                    // -- subtitle text --
                    Text(
                      pageObject["subtitle"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.2,
                    ),
                  ],
                );
              }),
          // -- next button --
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.width * 1.5,
              ),

              // -- dot page indicator --
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pageArray.map((e) {
                  var index = pageArray.indexOf(e);
                  return Container(
                    width: index == selectPage ? 12 : 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index == selectPage
                          ? TColor.primaryColor
                          : TColor.placeHolder,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: media.width * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RoundButton(
                  onPressed: () {
                    if (selectPage >= 2) {
                      // home screen
                      print("GO Home");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainTabview()));
                    } else {
                      // next screen
                      setState(() {
                        selectPage = selectPage + 1;
                        controller.animateToPage(selectPage,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.bounceInOut);
                      });
                    }
                  },
                  title: 'Next',
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
