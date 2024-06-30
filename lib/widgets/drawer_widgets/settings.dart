import 'package:flutter/material.dart';
import 'package:quran_tutorial/globalhelpers/constants.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EDD8),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
        centerTitle: true,
        title: const Text(
          "الاعدادات",
          style: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xffF5EDD8),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'حجم خط المصحف',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Slider(
                    activeColor: Colors.brown,
                    value: arabicFontSize,
                    min: 20,
                    max: 40,
                    onChanged: (value) {
                      setState(() {
                        arabicFontSize = value;
                      });
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                        onPressed: () {
                          setState(() {
                            arabicFontSize = 25; // default
                          });

                          saveSettings();
                        },
                        child: const Text(
                          'إعادة الضبط',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown),
                        onPressed: () {
                          saveSettings();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'حفظ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
