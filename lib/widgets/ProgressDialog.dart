import 'package:cab_rider/brand_colors.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String status;
  const ProgressDialog({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            const SizedBox(
              width: 5,
            ),
            const CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(BrandColors.colorAccent),
            ),
            const SizedBox(
              width: 25.0,
            ),
            Text(
              status,
              style: const TextStyle(
                fontSize: 15,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
