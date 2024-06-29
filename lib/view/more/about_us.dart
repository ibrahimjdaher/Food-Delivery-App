import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import 'my_order.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  List aboutTextArray = [
    "Welcome to Happy Meal, your ultimate app for fast, reliable, "
    "and convenient food delivery services! Our mission is to bring "
    "happiness to your meals by delivering your favorite dishes from "
    "local restaurants right to your doorstep. Whether you're craving"
    " a hearty breakfast, a quick lunch, or a delightful dinner, Happy "
    "Meal is here to make it happen.",
    "Happy Meal is a state-of-the-art food delivery platform created"
    " to connect you with a diverse range of culinary delights from "
    "your favorite local eateries. Founded by a team of food enthusiasts"
    " and technology experts, we are dedicated to leveraging innovation to "
    "provide you with the best dining experiences at home.",
    "Have questions or need assistance? Reach out to our friendly customer "
    "support team at support@happymeal.com or call us at 1-800-HAPPYMEAL. "
    "Follow us on social media for updates, promotions, and more!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 46),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(size: 22, Icons.arrow_back_ios),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    "About Us",
                    style: TextStyle(
                      color: TColor.primaryText,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const MyOrder()),
                      );
                    },
                    icon: const Icon(size: 25, Iconsax.shopping_cart),
                  ),
                ],
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: aboutTextArray.length,
              itemBuilder: ((context, index) {
                var txt = aboutTextArray[index] as String? ?? "";
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: TColor.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          txt,
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
