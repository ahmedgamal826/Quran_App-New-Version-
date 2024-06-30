import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:quran_tutorial/widgets/drawer_widgets/myDrawer.dart';
import 'package:quran_tutorial/widgets/filtered_data_listView.dart';
import 'package:quran_tutorial/widgets/search_name_listView.dart';
import 'package:quran_tutorial/widgets/search_nums_listView.dart';
import 'package:quran_tutorial/widgets/search_text_field.dart';
import 'package:quran_tutorial/views/quran_page_view.dart';
import 'package:quran/quran.dart';

import 'package:quran_tutorial/globalhelpers/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class HomePage extends StatefulWidget {
  var suraJsonData;

  HomePage({Key? key, required this.suraJsonData}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<HomePage> {
  bool isLoading = true;

  var searchQuery = "";
  var filteredData;
  var ayatFiltered;
  late SharedPreferences prefs;
  String savedVerseKey = "saved_verse";

  List<int> pageNumbers = [];
  var savedPageNumber;
  late TextEditingController SearchSurahController = TextEditingController();

  void addFilteredData() async {
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      filteredData = widget.suraJsonData;
      isLoading = false;
    });
  }

  void saveVerse(int pageNumber) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt(savedVerseKey, pageNumber);
  }

  void loadSavedVerse() async {
    prefs = await SharedPreferences.getInstance();
    int? savedPage = prefs.getInt(savedVerseKey);
    if (savedPage != null) {
      setState(() {
        savedPageNumber = savedPage;
      });
    }
  }

  void performSearch(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
    addFilteredData();
    loadSavedVerse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quranPagesColor,
      appBar: AppBar(
        backgroundColor: const Color(0xffF1EEE5),
        centerTitle: true,
        title: const Text(
          "فهرس القرآن الكريم",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {
              if (savedPageNumber != 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuranPageView(
                      pageNumber: savedPageNumber,
                      jsonData: widget.suraJsonData,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('لم يتم حفظ أية بعد'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                SearchTextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });

                      if (value.isEmpty) {
                        filteredData = widget.suraJsonData; // show filteredData
                        pageNumbers.clear();
                      } else if (searchQuery.isNotEmpty &&
                          isNumeric(searchQuery) &&
                          int.parse(searchQuery) < 605 &&
                          int.parse(searchQuery) > 0) {
                        pageNumbers.add(int.parse(searchQuery));
                      } else if (searchQuery.length > 3 ||
                          searchQuery.toString().contains(" ")) {
                        setState(() {
                          ayatFiltered = [];

                          ayatFiltered = searchWords(searchQuery);
                        });
                      } else {
                        // Reset filtered data
                        ayatFiltered = null;
                        filteredData = widget.suraJsonData.where((sura) {
                          final suraName = sura['name'].toLowerCase();
                          final suraNameArabic =
                              getSurahNameArabic(sura["number"]);

                          return (suraName
                                  .contains(searchQuery.toLowerCase()) ||
                              suraNameArabic.contains(searchQuery));
                        }).toList();

                        // Clear page numbers when searching for surah names
                        pageNumbers.clear();

                        // Display surahs matching the search query
                        filteredData.forEach((sura) {
                          int surahNumber = sura['number'];

                          pageNumbers.add(surahNumber);
                        });
                      }
                    },
                    SearchSurahController: SearchSurahController,
                    suraJsonData: widget.suraJsonData,
                    filterdData: filteredData,
                    ayaFiltered: ayatFiltered,
                    pageNumbers: pageNumbers),
                if (pageNumbers.isEmpty &&
                    searchQuery.isNotEmpty &&
                    ((int.tryParse(searchQuery) ?? 0) <= 0 ||
                        (int.tryParse(searchQuery) ?? 0) >= 605))
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'لا توجد نتائج',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                pageNumbers.isNotEmpty
                    ? Column(
                        children: [
                          SearchNumbersListView(
                            pageNumbers: pageNumbers,
                            onTap: (index) {
                              performSearch(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuranPageView(
                                          pageNumber: pageNumbers[index],
                                          jsonData: widget.suraJsonData)));
                            },
                          ),
                          SearchNameListView(
                            saveVerse: saveVerse,
                            filterdData: filteredData,
                            jsonData: widget.suraJsonData,
                          )
                        ],
                      )
                    : FilteredDataListView(
                        filteredData: filteredData,
                        jsonData: widget.suraJsonData,
                        saveVerse: saveVerse),
                //if (ayatFiltered != null)
                // AyatFilteredListview(
                //     jsonData: widget.suraJsonData,
                //     ayatFiltered: ayatFiltered,
                //     saveVerse: saveVerse),

                if (ayatFiltered != null)
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ayatFiltered["occurences"] > 10
                        ? 10
                        : ayatFiltered["occurences"],
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: EasyContainer(
                          color: Colors.white70,
                          borderRadius: 14,
                          onTap: () async {
                            int verseNumber = ayatFiltered["verses"][index];
                            int surahNumber =
                                ayatFiltered["result"][index]["surah"];
                            int pageNumber =
                                getPageNumber(surahNumber, verseNumber);
                            saveVerse(pageNumber);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuranPageView(
                                  pageNumber: pageNumber,
                                  jsonData: widget.suraJsonData,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "سورة ${getSurahNameArabic(ayatFiltered["result"][index]["surah"])} - ${getVerse(ayatFiltered["result"][index]["surah"], ayatFiltered["result"][index]["verse"], verseEndSymbol: true)}",
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 17),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
    );
  }
}
