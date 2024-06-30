import 'package:flutter/material.dart';

class PrayerCompleteQuran extends StatelessWidget {
  const PrayerCompleteQuran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffF5EDD8),
          iconTheme: const IconThemeData(
            size: 30,
          ),
          centerTitle: true,
          title: const Text(
            'دعاء ختم القرآن',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/images/dua-hands.png',
                width: 40,
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: PageView(
          reverse: true,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/prayer11.jpg'),
                    fit: BoxFit.fill),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/prayer22.jpg'),
                    fit: BoxFit.fill),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
