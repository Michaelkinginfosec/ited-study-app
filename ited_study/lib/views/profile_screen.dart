// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ited_study/views/about_us.dart';

import '../core/widgets/custom_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        "assets/images/rema.jpeg",
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 10,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Osunde Goodluck Michael",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 5, 45, 1),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("100"),
                          Text("LEVEL"),
                        ],
                      ),
                      Column(
                        children: [
                          Text("4.52"),
                          Text("C.G.P.A"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomListTile(
              subTitle: Text("Update you personal profile"),
              title: Text("Edit Profile"),
              icon: Icon(
                CupertinoIcons.profile_circled,
              ),
            ),
            CustomListTile(
              subTitle: Text("Security and Privacy of your account"),
              title: Text("Settings"),
              icon: Icon(
                CupertinoIcons.settings,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
              child: CustomListTile(
                subTitle: Text("Mission, Vision, Terms and Conditions"),
                title: Text("About Us"),
                icon: Icon(
                  CupertinoIcons.info_circle_fill,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: CustomListTile(
                subTitle: Text("Sign Out of your account"),
                title: Text("Log Out"),
                icon: Icon(
                  Icons.logout_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
