import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:quran_tutorial/widgets/directionality_widget.dart';
import 'package:quran_tutorial/widgets/parts_surahs.dart';

class SingleChildScrollViewWidget extends StatelessWidget {
  SingleChildScrollViewWidget(
      {super.key, required this.index, required this.jsonData});

  int index;
  var jsonData;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textScaleFactor =
        screenWidth / 400; // Adjust 400 as a base screen width
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenWidth / 3),
                child: Text(
                  'سُورَةٌ ${jsonData[getPageData(index)[0]['surah'] - 1]["name"]}',
                  style: TextStyle(
                    fontSize: 18 * textScaleFactor,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "$index",
                style: TextStyle(
                  fontSize: 18 * textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenWidth / 3.8),
                child: Container(
                  child: Center(
                    child: PartIndicator(index),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CustomDirectionality(
            index: index,
            jsonData: jsonData,
          )
        ],
      ),
    );
  }
}
