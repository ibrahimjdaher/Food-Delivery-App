import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/round_button.dart';
import '../../common/colors.dart';
import 'checkout.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List itemArray = [
    {
      "name": "Beef Burger",
      "quantity": 1,
      "price": 14.0,
    },
    {
      "name": "Classic Burger",
      "quantity": 3,
      "price": 14.0,
    },
    {
      "name": "Cheese Chicken Burger",
      "quantity": 2,
      "price": 14.0,
    },
    {
      "name": "Chicken Legs Basket",
      "quantity": 2,
      "price": 16.0,
    },
    {
      "name": "French Fries Large",
      "quantity": 1,
      "price": 8.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 46),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(size: 22, Icons.arrow_back_ios),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        "My Order",
                        style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                          "assets/images/food/shop_logo.png",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "King Burger",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: TColor.primaryText,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 3, right: 2),
                                      child: Icon(
                                        Icons.star_rate,
                                        size: 15,
                                        color: Color(0xffEFD32A),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                    const Text(
                                      "4.3",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "(177 Ratings)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: TColor.secondaryText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "Burger",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: TColor.secondaryText,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      " . ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: TColor.primaryColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "Western Food",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: TColor.secondaryText,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 3, right: 2),
                                      child: Icon(
                                        Icons.location_on_rounded,
                                        size: 14,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "No 02, 3rd Lane, NewYork",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: TColor.secondaryText,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: TColor.textField,
                  ),
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: itemArray.length,
                    separatorBuilder: ((context, index) => Divider(
                          indent: 25,
                          endIndent: 25,
                          color: TColor.secondaryText.withOpacity(0.5),
                          height: 1,
                        )),
                    itemBuilder: ((context, index) {
                      var iObj = itemArray[index] as Map? ?? {};
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 25),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "${iObj["name"].toString()} x ${iObj["quantity"].toString()}",
                                style: TextStyle(
                                  color: TColor.primaryText,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              "\$${iObj["price"].toString()}",
                              style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Expanded(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Delivery Instructions",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: TColor.primaryColor,
                                  ),
                                  label: Text(
                                    "Add Notes",
                                    style: TextStyle(
                                      color: TColor.primaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 1,
                              color: TColor.secondaryText.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Sub Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "\$124",
                                  style: TextStyle(
                                    color: TColor.primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Delivery Cost",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "\$15",
                                  style: TextStyle(
                                    color: TColor.primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Divider(
                              height: 1,
                              color: TColor.secondaryText.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "\$139",
                                  style: TextStyle(
                                    color: TColor.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            RoundButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Checkout()),
                                );
                              },
                              title: 'Checkout',
                            ),
                            const SizedBox(
                              height: 25,
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
