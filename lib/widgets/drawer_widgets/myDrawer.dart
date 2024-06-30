// import 'package:flutter/material.dart';
// import 'package:quran_tutorial/widgets/drawer_widgets/prayer_complete_quran.dart';
// import 'package:quran_tutorial/widgets/drawer_widgets/settings.dart';
// import 'package:quran_tutorial/widgets/drawer_widgets/stop_signs.dart';
// import 'package:share_plus/share_plus.dart';

// class DrawerWidget extends StatelessWidget {
//   const DrawerWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Directionality(
//         textDirection: TextDirection.rtl,
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: DrawerHeader(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30),
//                       color: const Color(0xffF5EDD8),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'assets/images/quran.png',
//                           width: 90,
//                         ),
//                         const Text(
//                           'القرآن الكريم',
//                           style: TextStyle(
//                               fontSize: 25, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height,
//                   color: const Color(0xffF1EEE5),
//                   child: Column(
//                     children: [
//                       InkWell(
//                         splashColor: Colors.grey,
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const Settings()));
//                         },
//                         child: const ListTile(
//                           leading: Icon(
//                             Icons.settings,
//                             size: 30,
//                           ),
//                           title: Text(
//                             'الاعدادات',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         splashColor: Colors.red,
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const PrayerCompleteQuran()));
//                         },
//                         child: ListTile(
//                           leading: Image.asset(
//                             'assets/images/dua-hands.png',
//                             width: 37,
//                           ),
//                           title: const Text(
//                             'دعاء ختم القرآن',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const StopSigns()));
//                         },
//                         child: ListTile(
//                           leading: Image.asset(
//                             'assets/images/stop_signs_image.jpg',
//                             width: 40,
//                           ),
//                           title: const Text(
//                             'علامات الوقف',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Share.share('https://www.google.com');
//                         },
//                         child: const ListTile(
//                           leading: Icon(
//                             Icons.share,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                       // ListTile(
//                       //   leading: Icon(Icons.share),
//                       //   title: const Text(
//                       //     'مشاركة',
//                       //     style: TextStyle(
//                       //         fontSize: 20, fontWeight: FontWeight.bold),
//                       //   ),
//                       //   onTap: () {
//                       //     Share.share('https://www.google.com');
//                       //     Navigator.pop(context);
//                       //   },
//                       // ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quran_tutorial/widgets/drawer_widgets/prayer_complete_quran.dart';
import 'package:quran_tutorial/widgets/drawer_widgets/settings.dart';
import 'package:quran_tutorial/widgets/drawer_widgets/stop_signs.dart';
import 'package:quran_tutorial/widgets/test.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xffF5EDD8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/quran.png',
                          width: 90,
                        ),
                        const Text(
                          'القرآن الكريم',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0xffF1EEE5),
                  child: Column(
                    children: [
                      InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Settings()));
                        },
                        child: const ListTile(
                          leading: Icon(
                            Icons.settings,
                            size: 30,
                          ),
                          title: Text(
                            'الاعدادات',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.red,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PrayerCompleteQuran()));
                        },
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/dua-hands.png',
                            width: 37,
                          ),
                          title: const Text(
                            'دعاء ختم القرآن',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StopSigns()));
                        },
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/stop_signs_image.jpg',
                            width: 40,
                          ),
                          title: const Text(
                            'علامات الوقف',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
