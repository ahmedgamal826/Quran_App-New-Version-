import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:quran_tutorial/widgets/page_juz_map.dart';
import 'package:quran_tutorial/widgets/singleChildScrollView_Widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

class QuranPageView extends StatefulWidget {
  QuranPageView({
    Key? key,
    required this.pageNumber,
    required this.jsonData,
  }) : super(key: key);

  final int pageNumber;
  final dynamic jsonData;

  @override
  _QuranPageViewState createState() => _QuranPageViewState();
}

class _QuranPageViewState extends State<QuranPageView> {
  late PageController pageController;
  late SharedPreferences prefs;
  String savedPageKey = "saved_page";
  bool isPageSaved = false;
  int? savedPageNumber;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.pageNumber);
    Wakelock.enable();
    loadSavedPage();
  }

  Future<void> savePage(int page) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setInt(savedPageKey, page); // save page
    setState(() {
      isPageSaved = true;
      savedPageNumber = page;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          textDirection: TextDirection.rtl,
          'تم حفظ الصفحة ',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Future<void> loadSavedPage() async {
    prefs = await SharedPreferences.getInstance();
    int? savedPage = prefs.getInt(savedPageKey);
    if (savedPage != null) {
      pageController.jumpToPage(savedPage);
      setState(() {
        isPageSaved = true; // saved page
        savedPageNumber = savedPage;
      });
    }
  }

  Future<void> deleteSavedPage() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove(savedPageKey); // delete saved page
    setState(() {
      isPageSaved = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          textDirection: TextDirection.rtl,
          'تم حذف الصفحة المحفوظة',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void showJuzDialog(int juzNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.brown, borderRadius: BorderRadius.circular(40)),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'الجزء $juzNumber',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Hide the dialog after 2 seconds
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  int getJuzForPage(int pageNumber) {
    for (var entry in pageJuzMap.entries) {
      // entries ==> key and value in map
      if (pageNumber < entry.key) {
        // (page 21 < key = 22) => juz 1
        return entry.value - 1;
      }
    }
    return pageJuzMap.entries.last.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: PageView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        onPageChanged: (int page) {
          setState(() {
            int juzNumber = getJuzForPage(page);
            if (pageJuzMap.containsKey(page)) {
              showJuzDialog(juzNumber);
            }
          });
        },
        itemCount: totalPagesCount + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: const Color(0xffFFFCE7),
              child: Image.asset(
                "assets/images/quran_image.jpg",
                fit: BoxFit.fill,
              ),
            );
          } else {
            return Stack(
              children: [
                Container(
                  child: Scaffold(
                    backgroundColor: const Color(0xffF5EDD8),
                    appBar: AppBar(
                      backgroundColor: const Color(0xffF5EDD8),
                      centerTitle: true,
                      title: const Text('القرآن الكريم'),
                      actions: [
                        IconButton(
                          icon: Icon(isPageSaved && index == savedPageNumber
                              ? Icons.bookmark
                              : Icons.bookmark_border),
                          onPressed: () {
                            if (isPageSaved && index == savedPageNumber) {
                              deleteSavedPage();
                            } else {
                              savePage(pageController.page!.toInt());
                            }
                          },
                        ),
                      ],
                    ),
                    body: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: SingleChildScrollViewWidget(
                            index: index, jsonData: widget.jsonData),
                      ),
                    ),
                  ),
                ),
                if (isPageSaved && index == savedPageNumber)
                  Positioned(
                    top: 0,
                    bottom: MediaQuery.of(context).size.height / 1.2,
                    right: MediaQuery.of(context).size.width / 1.2,
                    child: Container(
                      width: 25,
                      color: Colors.red.withOpacity(0.6),
                    ),
                  ),
              ],
            );
          }
        },
      ),
    );
  }
}
