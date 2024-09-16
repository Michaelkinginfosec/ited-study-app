// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ited_study/core/constants/boxsize.dart';
import 'package:ited_study/core/constants/text_style.dart.dart';
import 'package:ited_study/core/route/route.dart';

class SetttingsScreen extends StatelessWidget {
  const SetttingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: CustomTextStyles.mediumSubtitleText,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
            CustomSizeBox.mediumBox,
            Text(
              "Osunde Goodluck Michael",
              style: CustomTextStyles.nameTitle,
            ),
            CustomSizeBox.mediumBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "100",
                            style: CustomTextStyles.mediumSubtitleText,
                          ),
                          Text("LEVEL", style: CustomTextStyles.levelTitle),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "60%",
                            style: CustomTextStyles.mediumSubtitleText,
                          ),
                          Text("course completion",
                              style: CustomTextStyles.levelTitle),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "4.52",
                            style: CustomTextStyles.mediumSubtitleText,
                          ),
                          Text("C.G.P.A", style: CustomTextStyles.levelTitle),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    CustomSizeBox.mediumBox,
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.editprofile);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/editbio.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Edit Profile",
                                  style: CustomTextStyles.normalTextSetting,
                                ),
                                Text("Update you personal profile",
                                    style: CustomTextStyles.textSettings)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomSizeBox.box,
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.changepassword);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/reset.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password Reset",
                                  style: CustomTextStyles.normalTextSetting,
                                ),
                                Text(
                                  "Change your password",
                                  style: CustomTextStyles.textSettings,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomSizeBox.box,
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.activate);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/activate.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "App Activation",
                                  style: CustomTextStyles.normalTextSetting,
                                ),
                                Text(
                                  "Get activated to unlock full access",
                                  style: CustomTextStyles.textSettings,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomSizeBox.box,
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.aboutus);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/aboutus.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "About Us",
                                  style: CustomTextStyles.normalTextSetting,
                                ),
                                Text(
                                  "Mission, Vision, Terms and Conditions",
                                  style: CustomTextStyles.textSettings,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomSizeBox.box,
                    GestureDetector(
                      onTap: () {},
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/logout.png",
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Log Out",
                                  style: CustomTextStyles.normalTextSetting,
                                ),
                                Text(
                                  "Sign Out of your account",
                                  style: CustomTextStyles.textSettings,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
