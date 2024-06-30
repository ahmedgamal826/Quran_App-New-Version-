import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:quran/surah_data.dart';
import 'package:quran_tutorial/globalhelpers/constants.dart';
import 'package:quran_tutorial/views/quran_page_view.dart';

class FilteredDataListView extends StatelessWidget {
  FilteredDataListView(
      {super.key,
      required this.filteredData,
      required this.saveVerse,
      required this.jsonData});

  var filteredData;
  final void Function(int) saveVerse;
  var jsonData;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Divider(
          color: Colors.grey.withOpacity(.5),
        ),
      ),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        int suraNumber = filteredData[index]["number"];
        String suraNameArabic = filteredData[index]["name"];
        String place = filteredData[index]["revelationType"];

        return Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            child: ListTile(
              leading: SizedBox(
                width: 45,
                height: 45,
                child: Center(
                  child: Text(
                    suraNumber.toString(),
                    style: const TextStyle(
                      color: blackColor,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        'آياتها',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        surah[index]['aya'].toString(),
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    place == 'Meccan'
                        ? 'assets/images/kaaba.png'
                        : 'assets/images/prophet.png',
                    width: 40,
                  ),
                ],
              ),
              trailing: Text(
                suraNameArabic,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                  fontSize: 23,
                ),
              ),
              onTap: () async {
                int verseNumber = 1; // Assuming verse number 1

                int pageNumber = getPageNumber(suraNumber, verseNumber);
                saveVerse(pageNumber);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuranPageView(
                      pageNumber: pageNumber,
                      jsonData: jsonData,
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
