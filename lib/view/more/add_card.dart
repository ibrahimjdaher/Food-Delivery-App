import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/widgets/round_icon_button.dart';
import 'package:food_delivery/widgets/round_textfield.dart';
import 'package:iconsax/iconsax.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController txtCardNumber = TextEditingController();
  TextEditingController txtCardMonth = TextEditingController();
  TextEditingController txtCardYear = TextEditingController();
  TextEditingController txtCardCode = TextEditingController();
  TextEditingController txtFirstName = TextEditingController();
  TextEditingController txtLastName = TextEditingController();
  bool isAnyTime = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Container(
      width: media.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add Credit/Debit Card",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Iconsax.close_circle,
                    color: TColor.primaryText,
                    size: 23,
                  )),
            ],
          ),
          Divider(
            color: TColor.secondaryText.withOpacity(0.4),
            height: 1,
          ),
          const SizedBox(height: 15),
          RoundTextField(
            hintText: 'Card Number',
            controller: txtCardNumber,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                "Expiry",
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 100,
                child: RoundTextField(
                  hintText: 'MM',
                  controller: txtCardMonth,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: RoundTextField(
                  hintText: 'YYYY',
                  controller: txtCardYear,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          RoundTextField(
            hintText: 'Card Security Code',
            controller: txtCardCode,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          RoundTextField(
            hintText: 'First Name',
            controller: txtFirstName,
          ),
          const SizedBox(height: 15),
          RoundTextField(
            hintText: 'Last Name',
            controller: txtLastName,
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Text(
                'You can remove this card at any time',
                style: TextStyle(
                  color: TColor.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Switch(
                  value: isAnyTime,
                  activeColor: TColor.primaryColor,
                  onChanged: (newVal) {
                    setState(() {
                      isAnyTime = newVal;
                    });
                  }),
            ],
          ),
          const SizedBox(height: 25),
          RoundIconButton(
            title: 'Add Card',
            fontSize: 17,
            icon: 'assets/images/more/add.png',
            iconHeight: 17,
            iconWidth: 17,
            fontWeight: FontWeight.w600,
            color: TColor.primaryColor,
            onPressed: () {},
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
