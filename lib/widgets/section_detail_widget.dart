import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../helpers/helpers.dart';
import 'chip_widget.dart';

class SectionDetail extends StatelessWidget {
  final String label;
  final dynamic data;
  final Color color;
  final String type;
  const SectionDetail(
      {super.key,
      required this.label,
      required this.data,
      required this.color,
      required this.type});

  String? getLabel(dynamic i) {
    switch (type) {
      case "types":
        return i?.type!.name!;
      case "abilities":
        return i?.ability!.name!;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          data is List
              ? SingleChildScrollView(
                  child: Row(
                    children: [
                      for (var i in data)
                        ChipWidget(
                          color: color,
                          label: getLabel(i) ?? "",
                        )
                    ],
                  ),
                )
              : Container(),
          data is! List
              ? Row(
                  children: [ChipWidget(color: color, label: data.toString())],
                )
              : Container()
        ],
      ),
    );
  }
}
