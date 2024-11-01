// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ited_study/core/constants/boxsize.dart';
import 'package:ited_study/core/constants/text_style.dart.dart';
import 'package:ited_study/core/route/route.dart';
import 'package:ited_study/feature/auth/presentation/providers/logout_provide.dart';

class SetttingsScreen extends ConsumerWidget {
  const SetttingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var box = Hive.box('usersBox');
    var user = box.get('users');
    print("this  $user");

    final logOutState = ref.watch(logoutNotifierProvider);
    ref.listen<LogoutState>(
      logoutNotifierProvider,
      (previous, next) {
        if (next.status == LogoutStatus.success) {
          context.pushReplacement(AppRoutes.login);
        } else if (next.status == LogoutStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error ?? 'Logout failed'),
            ),
          );
        }
      },
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: logOutState.status == LogoutStatus.loading
          ? Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  CustomSizeBox.extralBig,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Settings',
                        style: CustomTextStyles.normalTextSetting2,
                      ),
                    ),
                  ),
                  CustomSizeBox.mediumBox,
                  Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 5, 45, 1),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 130,
                              height: 150,
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
                    ],
                  ),
                  CustomSizeBox.smallBox,
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
                                Text("LEVEL",
                                    style: CustomTextStyles.levelTitle),
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
                                Text("C.G.P.A",
                                    style: CustomTextStyles.levelTitle),
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
                  Padding(
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
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(0, 5, 45, 1),
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/checkmark.png",
                                        ),
                                        Text(
                                          "Alert",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    content: Text(
                                      "Are you sure you want to signout?",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          ref
                                              .read(logoutNotifierProvider
                                                  .notifier)
                                              .logout();
                                        },
                                        child: Text("Sign Out",
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(0, 5, 45, 1),
                                            )),
                                      ),
                                    ],
                                  );
                                });
                          },
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
                ],
              ),
            ),
    );
  }
}
