import 'package:flutter/material.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common/service_call.dart';
import 'package:food_delivery/widgets/most_popular_cell.dart';
import 'package:food_delivery/widgets/popular_restaurant_row.dart';
import 'package:food_delivery/widgets/recent_item_row.dart';
import 'package:food_delivery/widgets/round_textfield.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import '../../widgets/category_cell.dart';
import '../../widgets/view_all_title_row.dart';
import '../more/my_order.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtSearch = TextEditingController();
  List categoryArray = [
    {"image": "assets/images/food/cat_offer.png", "name": "Offers"},
    {"image": "assets/images/food/cat_sri.png", "name": "Sri Lankan"},
    {"image": "assets/images/food/cat_3.png", "name": "Italian"},
    {"image": "assets/images/food/cat_4.png", "name": "Indian"},
  ];
  List popularArray = [
    {
      "image": "assets/images/food/res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.6",
      "rating": "122",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/images/food/res_2.png",
      "name": "Cafe de Noir",
      "rate": "4.1",
      "rating": "233",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/images/food/res_3.png",
      "name": "Bakes by Tella",
      "rate": "3.8",
      "rating": "39",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];
  List mostPopularArray = [
    {
      "image": "assets/images/food/m_res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.6",
      "rating": "122",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/images/food/m_res_2.png",
      "name": "Cafe de Noir",
      "rate": "4.1",
      "rating": "233",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];
  List recentArray = [
    {
      "image": "assets/images/food/item_1.png",
      "name": "Mulberry Pizza by Josh",
      "rate": "3.5",
      "rating": "56",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/images/food/item_2.png",
      "name": "Barita",
      "rate": "4.7",
      "rating": "343",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/images/food/item_3.png",
      "name": "Pizza Rush Hour",
      "rate": "4.2",
      "rating": "76",
      "type": "Cafa",
      "food_type": "Western Food"
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
          child: Column(
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // -- good morning text --
                    Text(
                      "Good Morning ${ServiceCall.userPayload[KKey.name] ?? ""}!",
                      style: TextStyle(
                        color: TColor.primaryText,
                        fontSize: 20,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Delivering to text --
                    Text(
                      "Delivering to",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 11,
                      ),
                    ),

                    const SizedBox(height: 2),

                    // -- Current Location text --
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Current Location",
                          style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          size: 25,
                          Icons.keyboard_arrow_down_rounded,
                          color: TColor.primaryColor,
                        ),
                      ],
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
                height: 25,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: categoryArray.length,
                    itemBuilder: ((context, index) {
                      var cObj = categoryArray[index] as Map? ?? {};
                      return CategoryCell(
                        onTap: () {},
                        cObj: cObj,
                      );
                    })),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Popular Restaurants",
                  onView: () {},
                ),
              ),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: popularArray.length,
                itemBuilder: ((context, index) {
                  var pObj = popularArray[index] as Map? ?? {};
                  return PopularRestaurantRow(
                    onTap: () {},
                    pObj: pObj,
                  );
                }),
              ),
              const SizedBox(
                height: 15,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Most Popular",
                  onView: () {},
                ),
              ),

              SizedBox(
                height: 190,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: mostPopularArray.length,
                    itemBuilder: ((context, index) {
                      var mObj = mostPopularArray[index] as Map? ?? {};
                      return MostPopularCell(
                        onTap: () {},
                        mObj: mObj,
                      );
                    }),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ViewAllTitleRow(
                  title: "Recent Items",
                  onView: () {},
                ),
              ),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: recentArray.length,
                itemBuilder: ((context, index) {
                  var rObj = recentArray[index] as Map? ?? {};
                  return RecentItemRow(
                    onTap: () {},
                    rObj: rObj,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
