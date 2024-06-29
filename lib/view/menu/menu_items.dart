import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/menu_item_row.dart';
import 'package:food_delivery/widgets/round_textfield.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import '../more/my_order.dart';
import 'item_details.dart';

class MenuItemsView extends StatefulWidget {
  final Map mObj;

  const MenuItemsView({super.key, required this.mObj});

  @override
  State<MenuItemsView> createState() => _MenuItemsViewState();
}

class _MenuItemsViewState extends State<MenuItemsView> {
  TextEditingController txtSearch = TextEditingController();

  List menuItemsArray = [
    {
      "image": "assets/images/food/dess_1.png",
      "name": "French Apple Pie",
      "rate": "4.6",
      "rating": "122",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/images/food/dess_2.png",
      "name": "Dark Chocolate Cake",
      "rate": "4.1",
      "rating": "233",
      "type": "Cakes by Tella",
      "food_type": "Desserts"
    },
    {
      "image": "assets/images/food/dess_3.png",
      "name": "Street Shake",
      "rate": "3.8",
      "rating": "39",
      "type": "Cafe Racer",
      "food_type": "Desserts"
    },
    {
      "image": "assets/images/food/dess_4.png",
      "name": "Fudgy Chewy Brownies",
      "rate": "3.8",
      "rating": "39",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/images/food/dess_1.png",
      "name": "French Apple Pie",
      "rate": "4.6",
      "rating": "122",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/images/food/dess_2.png",
      "name": "Dark Chocolate Cake",
      "rate": "4.1",
      "rating": "233",
      "type": "Cakes by Tella",
      "food_type": "Desserts"
    },
    {
      "image": "assets/images/food/dess_3.png",
      "name": "Street Shake",
      "rate": "3.8",
      "rating": "39",
      "type": "Cafe Racer",
      "food_type": "Desserts"
    },
    {
      "image": "assets/images/food/dess_4.png",
      "name": "Fudgy Chewy Brownies",
      "rate": "3.8",
      "rating": "39",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
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
          child: Column(children: [
            const SizedBox(height: 46),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    widget.mObj["name"].toString(),
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
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: RoundTextField(
                hintText: "Search Food ..",
                controller: txtSearch,
                left: Container(
                  width: 30,
                  alignment: Alignment.center,
                  child: const Icon(
                    Iconsax.search_normal,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: menuItemsArray.length,
              itemBuilder: ((context, index) {
                var mObj = menuItemsArray[index] as Map? ?? {};
                return MenuItemRow(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ItemDetails()));
                  },
                  mObj: mObj,
                );
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
