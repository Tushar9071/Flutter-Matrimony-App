import 'package:flutter/material.dart';
import 'package:submition/Pages/Pages_app/about_us.dart';
import 'package:submition/Pages/Pages_app/favorite_page.dart';
import 'package:submition/Pages/Pages_app/home_page.dart';
import 'package:submition/Pages/Pages_app/list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedBottomIndex = 0;
  List<Widget> page = [
    HomePage(),
    ListPage(),
    FavoritePage(),
    AboutUsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   title: Text(
      //     'MATRIMONY',
      //     style: TextStyle(fontSize: 30),
      //   ),
      // ),
      body: page[selectedBottomIndex],
      // body: ListPage(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedBottomIndex,
          onTap: (value) {
            setState(() {
              selectedBottomIndex = value;
            });
          },
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'List of Users',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'About us',
                backgroundColor: Colors.black),
          ]),
    );
  }
}
