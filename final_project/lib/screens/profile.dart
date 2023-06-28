import 'package:final_project/controllers/user_controller.dart';
import 'package:final_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: UserController().getAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return loading();
          }
          return Padding(
            padding: EdgeInsets.only(left: 20.w, top: 25.h, right: 20.w),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    userDetails(snapshot),
                    options(context),
                  ],
                ),
                logout(context)
              ],
            ),
          );
        });
  }

  ListTile userDetails(AsyncSnapshot<User> snapshot) {
    return ListTile(
      title: Text(
        "${snapshot.data!.firstName[0].toUpperCase()}${snapshot.data!.firstName.substring(1)} ${snapshot.data!.lastName[0].toUpperCase()}${snapshot.data!.lastName.substring(1)}",
        style: const TextStyle(fontSize: 21),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Text(
          snapshot.data!.email,
        ),
      ),
    );
  }

  Column options(BuildContext context) {
    return Column(
      children: [
        ListTile(
            title: const Text("Addresses"),
            onTap: () {
              Navigator.pushNamed(context, "/address", arguments: false);
            }),
        ListTile(
            title: const Text("Orders"),
            onTap: () {
              Navigator.pushNamed(context, "/orders");
            }),
      ],
    );
  }

  Container logout(BuildContext context) {
    return Container(
      width: double.infinity,
      child: MaterialButton(
        color: Colors.red,
        elevation: 0,
        // shape: Border.all(color: Colors.red),
        onPressed: () {
          UserController().signout().then(
              (value) => Navigator.pushReplacementNamed(context, "/start"));
        },
        child: const Text(
          "Logout",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Center loading() =>
      const Center(child: CircularProgressIndicator(color: Colors.black));
}
