import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/widgets/round_button.dart';

class CheckoutMessage extends StatefulWidget {
  const CheckoutMessage({super.key});

  @override
  State<CheckoutMessage> createState() => _CheckoutMessageState();
}

class _CheckoutMessageState extends State<CheckoutMessage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      width: media.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: TColor.primaryText,
                  size: 25,
                ),
              ),
            ],
          ),
          Image.asset(
            "assets/images/thank_you.png",
            width: media.width * 0.55,
          ),
          const SizedBox(height: 25),
          Text(
            "Thank You!",
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "for your order",
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 25),
          Text(
            "Your order is now being processed. We will let you know once the order "
            "is picked from the outlet. Check the status of your order.",
            style: TextStyle(
              color: TColor.primaryText,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 35),
          RoundButton(onPressed: () {}, title: 'Track My Order'),
          TextButton(
            onPressed: () {},
            child: Text(
              "Back To Home",
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
