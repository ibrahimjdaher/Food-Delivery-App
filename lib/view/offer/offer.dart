import 'package:flutter/material.dart';
import 'package:food_delivery/widgets/popular_restaurant_row.dart';
import 'package:food_delivery/widgets/round_button.dart';
import 'package:iconsax/iconsax.dart';

import '../../common/colors.dart';
import '../more/my_order.dart';

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  TextEditingController txtSearch = TextEditingController();

  List offerArray = [
    {
      "image": "assets/images/food/offer_1.png",
      "name": "Cafe de Noires",
      "rate": "4.2",
      "rating": "66",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/images/food/offer_2.png",
      "name": "Isso",
      "rate": "4.3",
      "rating": "113",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/images/food/offer_3.png",
      "name": "Cafe Beans",
      "rate": "4.9",
      "rating": "232",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Offers",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -- Delivering to text --
                    Text(
                      "Find discounts, Offers special\nmeals and more.",
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 140,
                  height: 30,
                  child: RoundButton(
                      fontSize: 12,
                      onPressed: (){},
                      title: 'Check Offers'),
                ),
              ),
              const SizedBox(height: 15),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: offerArray.length,
                itemBuilder: ((context, index) {
                  var pObj = offerArray[index] as Map? ?? {};
                  return PopularRestaurantRow(
                    onTap: () {},
                    pObj: pObj,
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
