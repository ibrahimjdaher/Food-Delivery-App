import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import 'my_order.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  List inboxArray = [
    {
      "title": "MealMonkey Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "Harvey Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "Res Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "MealMonkey Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "Harvey Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "Res Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "MealMonkey Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "Harvey Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
    },
    {
      "title": "Res Promotions",
      "detail": "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg"
                "gggggggggggggggggggggggggggggggggggg",
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
                    "Inbox",
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
              itemCount: inboxArray.length,
              separatorBuilder: ((context, index) => Divider(
                indent: 25,
                endIndent: 25,
                color: TColor.secondaryText.withOpacity(0.4),
                height: 1,
              )),
              itemBuilder: ((context, index) {
                var iObj = inboxArray[index] as Map? ?? {};
                return Container(
                  decoration: BoxDecoration(
                    color: index % 4 != 1 ? Colors.white : TColor.textField,
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
                              iObj["title"].toString(),
                              style: TextStyle(
                                color: TColor.primaryText,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              iObj["detail"].toString(),
                              maxLines: 2,
                              style: TextStyle(
                                color: TColor.secondaryText,
                                fontSize: 14,
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
