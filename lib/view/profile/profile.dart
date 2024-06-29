import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/colors.dart';
import 'package:food_delivery/widgets/round_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/round_textfield.dart';
import '../more/my_order.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPhoneNumber = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 46,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Profile",
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
                      icon: Icon(
                        size: 25,
                        Iconsax.shopping_cart,
                        color: TColor.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: TColor.placeHolder,
                  borderRadius: BorderRadius.circular(55),
                ),
                alignment: Alignment.center,
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image.file(
                          File(image!.path),
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Iconsax.user,
                        size: 50,
                        color: TColor.secondaryText,
                      ),
              ),
              TextButton.icon(
                label: Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 13,
                    color: TColor.primaryColor,
                  ),
                ),
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                },
                icon: Icon(
                  Iconsax.edit,
                  size: 17,
                  color: TColor.primaryColor,
                ),
              ),
              Text(
                "Hi there Hema!",
                style: TextStyle(
                    fontSize: 18,
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Sign Out",
                  style: TextStyle(
                      fontSize: 12,
                      color: TColor.secondaryText,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundTitleTextField(
                  hintText: 'Enter Your Name',
                  title: 'Name',
                  controller: txtName,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundTitleTextField(
                  hintText: 'Enter Your Email',
                  title: 'Email',
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundTitleTextField(
                  hintText: 'Enter Your PhoneNumber',
                  title: 'PhoneNumber',
                  controller: txtPhoneNumber,
                  keyboardType: TextInputType.phone,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundTitleTextField(
                  hintText: 'Enter Your Address',
                  title: 'Address',
                  controller: txtAddress,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundTitleTextField(
                  hintText: '* * * * * *',
                  title: 'Password',
                  controller: txtPassword,
                  obscureText: true,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: RoundTitleTextField(
                  hintText: '* * * * * *',
                  title: 'Confirm Password',
                  controller: txtConfirmPassword,
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundButton(
                  onPressed: () {},
                  title: 'Save',
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
