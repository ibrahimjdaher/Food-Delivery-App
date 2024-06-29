import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import '../../widgets/round_textfield.dart';
import '../more/my_order.dart';
import 'menu_items.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  List menuArray = [
    {
      "name": "Food",
      "image": "assets/images/food/menu_1.png",
      "item_count": "24",
    },
    {
      "name": "Beverages",
      "image": "assets/images/food/menu_2.png",
      "item_count": "45",
    },
    {
      "name": "Desserts",
      "image": "assets/images/food/menu_3.png",
      "item_count": "24",
    },
    {
      "name": "Promotions",
      "image": "assets/images/food/menu_4.png",
      "item_count": "221",
    },
  ];
  TextEditingController txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(alignment: Alignment.centerLeft, children: [
        Container(
          margin: const EdgeInsets.only(
            top: 208,
          ),
          width: media.width * 0.27,
          height: media.height * 0.6,
          decoration: BoxDecoration(
            color: TColor.primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // -- menu text --
                    Text(
                      "Menu",
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
                        icon: const Icon(size: 25, Iconsax.shopping_cart)),
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
                height: 45,
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  itemCount: menuArray.length,
                  itemBuilder: ((context, index) {
                    var mObj = menuArray[index] as Map? ?? {};
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuItemsView(mObj: mObj),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 20),
                            width: media.width - 100,
                            height: 90,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(25),
                                  bottomLeft: Radius.circular(25),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 7,
                                    offset: Offset(0, 4),
                                  ),
                                ]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                mObj["image"].toString(),
                                width: 80,
                                height: 80,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      mObj["name"],
                                      style: TextStyle(
                                        color: TColor.primaryText,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      "${mObj["item_count"].toString()} items",
                                      style: TextStyle(
                                        color: TColor.secondaryText,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(17.5),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ]),
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  size: 30,
                                  color: TColor.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }))
            ]),
          ),
        ),
      ]),
    );
  }
}
