import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final Color color;
  final String label;
  const ChipWidget({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.do_not_disturb_on_total_silence_sharp,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 19, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
