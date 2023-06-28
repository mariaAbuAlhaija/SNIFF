import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/screens/brands.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Brands(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserController().getAll(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(),
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: bottomBar(),
          );
        });
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        home(),
        orders(),
        profile(),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      iconSize: 40,
      onTap: _onItemTapped,
      elevation: 5,
      showUnselectedLabels: false,
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0,
      centerTitle: true,
      elevation: 0,
      title: ColorFiltered(
          colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          child: Image.asset(
            "assets/images/sniff.png",
            width: 100.w,
            height: 150.w,
          )),
      actions: [
        cart(),
      ],
    );
  }

  BottomNavigationBarItem profile() {
    return const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
        size: 30,
      ),
      label: 'Profile',
    );
  }

  BottomNavigationBarItem orders() {
    return const BottomNavigationBarItem(
      icon: Icon(
        FontAwesomeIcons.flagCheckered,
        size: 25,
      ),
      label: 'Brands',
    );
  }

  BottomNavigationBarItem home() {
    return const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: 30,
      ),
      label: 'Home',
    );
  }

  Padding cart() {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/cart");
        },
        child: const Icon(
          FontAwesomeIcons.bagShopping,
          color: Colors.black54,
          size: 21,
        ),
      ),
    );
  }
}
