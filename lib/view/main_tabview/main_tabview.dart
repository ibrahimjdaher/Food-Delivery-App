import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/view/home/home.dart';
import 'package:food_delivery/view/more/more.dart';
import 'package:food_delivery/view/offer/offer.dart';
import 'package:food_delivery/widgets/tab_button.dart';
import 'package:iconsax/iconsax.dart';

import '../menu/menu.dart';
import '../profile/profile.dart';

class MainTabview extends StatefulWidget {
  const MainTabview({super.key});

  @override
  State<MainTabview> createState() => _MainTabviewState();
}

class _MainTabviewState extends State<MainTabview> {
  int selectTab = 2;
  PageStorageBucket storageBucket = PageStorageBucket();
  Widget selectPageView = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // -- navigation bar --
      body: PageStorage(bucket: storageBucket, child: selectPageView),
      // backgroundColor: const Color(0xfff5f5f5),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor:
              selectTab == 2 ? TColor.primaryColor : TColor.placeHolder,
          onPressed: () {
            if (selectTab != 2) {
              selectTab = 2;
              selectPageView = const Home();
            }
            if (mounted) {
              setState(() {});
            }
          },
          shape: const CircleBorder(),
          child: const Icon(
            Iconsax.home_1,
            size: 33,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        color: Colors.white,
        elevation: 2,
        notchMargin: 12,
        height: 70,
        shape: const CircularNotchedRectangle(),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              // -- menu button --
              TabButton(
                onTap: () {
                  if (selectTab != 0) {
                    selectTab = 0;
                    selectPageView = const MenuView();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'Menu',
                isSelected: selectTab == 0,
                icon: Iconsax.menu,
              ),

              // -- offer button --
              TabButton(
                onTap: () {
                  if (selectTab != 1) {
                    selectTab = 1;
                    selectPageView = const Offer();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'Offer',
                isSelected: selectTab == 1,
                icon: Iconsax.bag_2,
              ),

              const SizedBox(width: 40, height: 40,),

              // -- profile button --
              TabButton(
                onTap: () {
                  if (selectTab != 3) {
                    selectTab = 3;
                    selectPageView = const Profile();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'Profile',
                isSelected: selectTab == 3,
                icon: Iconsax.user,
              ),

              // -- more button --
              TabButton(
                onTap: () {
                  if (selectTab != 4) {
                    selectTab = 4;
                    selectPageView = const More();
                  }
                  if (mounted) {
                    setState(() {});
                  }
                },
                title: 'More',
                isSelected: selectTab == 4,
                icon: Iconsax.more,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
