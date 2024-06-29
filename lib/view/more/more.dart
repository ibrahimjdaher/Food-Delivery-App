import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/view/more/payment_details.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/service_call.dart';
import 'about_us.dart';
import 'inbox.dart';
import 'my_order.dart';
import 'notifications.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  List moreArray = [
    {
      "index": "1",
      "name": "Payment Details",
      "image": "assets/images/more/more_payment.png",
      "base": 0,
    },
    {
      "index": "2",
      "name": "My Orders",
      "image": "assets/images/more/more_my_order.png",
      "base": 0,
    },
    {
      "index": "3",
      "name": "Notifications",
      "image": "assets/images/more/more_notification.png",
      "base": 6,
    },
    {
      "index": "4",
      "name": "Inbox",
      "image": "assets/images/more/more_inbox.png",
      "base": 0,
    },
    {
      "index": "5",
      "name": "About us",
      "image": "assets/images/more/more_info.png",
      "base": 0,
    },
    {
      "index": "6",
      "name": "Logout",
      "image": "assets/images/more/logout.png",
      "base": 0,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "More",
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const MyOrder()),
                        );
                      },
                      icon: Icon(
                        size: 25,
                        Iconsax.shopping_cart,
                        color: TColor.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: moreArray.length,
                  itemBuilder: (context, index) {
                    var mObj = moreArray[index] as Map? ?? {};
                    var countBase = mObj["base"] as int? ?? 0;

                    return InkWell(
                      onTap: () {
                        switch (mObj["index"].toString()) {
                          case "1":
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const PaymentDetails()));
                            break;
                          case "2":
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const MyOrder()));
                            break;
                          case "3":
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Notifications()));
                            break;
                          case "4":
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const Inbox()));
                            break;
                          case "5":
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const AboutUs()));
                            break;
                          case "6":
                            ServiceCall.logout();
                            break;
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: TColor.textField,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: const EdgeInsets.only(right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: TColor.placeHolder,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      mObj["image"].toString(),
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      mObj["name"].toString(),
                                      style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  if (countBase > 0)
                                    Container(
                                      width: 25,
                                      height: 25,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                        BorderRadius.circular(12.5),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        countBase.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: TColor.textField,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: TColor.primaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
