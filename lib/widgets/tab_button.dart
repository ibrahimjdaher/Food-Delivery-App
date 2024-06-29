import 'package:flutter/material.dart';
import '../common/colors.dart';

class TabButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final bool isSelected;

  const TabButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.isSelected,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? TColor.primaryColor : TColor.placeHolder,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: TextStyle(
                color: isSelected ? TColor.primaryColor : TColor.placeHolder,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
