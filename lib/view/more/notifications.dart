import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import 'my_order.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List notificationArray = [
    {
      "title": "Your orders has been picked up",
      "time": "Now",
    },
    {
      "title": "Your orders has been delivered",
      "time": "1h ago",
    },
    {
      "title": "Your orders has been picked up",
      "time": "3h ago",
    },
    {
      "title": "Your orders has been delivered",
      "time": "5h ago",
    },
    {
      "title": "Your orders has been picked up",
      "time": "07 Jan 2024",
    },
    {
      "title": "Your orders has been delivered",
      "time": "04 Jan 2024",
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
                    "Notifications",
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
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: notificationArray.length,
              separatorBuilder: ((context, index) => Divider(
                    indent: 25,
                    endIndent: 25,
                    color: TColor.secondaryText.withOpacity(0.4),
                    height: 1,
                  )),
              itemBuilder: ((context, index) {
                var nObj = notificationArray[index] as Map? ?? {};
                return Container(
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.white : TColor.textField,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: TColor.primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nObj["title"].toString(),
                              style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              nObj["time"].toString(),
                              style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
