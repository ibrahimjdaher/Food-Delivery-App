import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final String title;
  final String icon;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final double iconHeight;
  final double iconWidth;
  final VoidCallback onPressed;

  const RoundIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onPressed,
    this.fontSize = 12,
    this.iconHeight = 27,
    this.iconWidth = 27,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: iconWidth,
              height: iconHeight,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
