import 'package:flutter/material.dart';

import '../brand_colors.dart';

class TaxiButton extends StatelessWidget {
  final String text;
  final void Function()? onpressed;
  final Color? color;

  const TaxiButton({
    super.key,
    required this.text,
    this.onpressed,
    this.color = BrandColors.colorGreen,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color,
      ),
      onPressed: onpressed,
      child: Text(
        // "LOGIN",
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
