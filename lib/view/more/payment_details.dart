import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/round_button.dart';
import 'package:food_delivery/widgets/round_icon_button.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import 'add_card.dart';
import 'my_order.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  List cardArray = [
    {
      "card": "**** **** **** 2187",
      "icon": "assets/images/more/visa_icon.png",
    },
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
                    "Payment Details",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: Text(
                "Customize your payment method",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Divider(
                color: TColor.secondaryText.withOpacity(0.4),
                height: 1,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: BoxDecoration(
                color: TColor.textField,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 10))
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cash/Card on Delivery",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          Icons.check,
                          color: TColor.primaryColor,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Divider(
                      color: TColor.secondaryText.withOpacity(0.4),
                      height: 1,
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: cardArray.length,
                    itemBuilder: ((context, index) {
                      var cObj = cardArray[index] as Map? ?? {};
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 35),
                        child: Row(
                          children: [
                            Image.asset(
                              cObj["icon"].toString(),
                              width: 50,
                              height: 35,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                cObj["card"].toString(),
                                style: TextStyle(
                                  color: TColor.secondaryText,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 100,
                              child: RoundButton(
                                onPressed: () {},
                                title: 'Delete Card',
                                fontSize: 12,
                                type: RoundButtonType.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Divider(
                      color: TColor.secondaryText.withOpacity(0.4),
                      height: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Other Methods",
                          style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: RoundIconButton(
                title: 'Add Another Credit/Debit Card',
                icon: 'assets/images/more/add.png',
                color: TColor.primaryColor,
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return const AddCard();
                      });
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => const AddCard()));
                },
                fontSize: 16,
                iconHeight: 16,
                iconWidth: 16,
              ),
            ),
            const SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }
}
