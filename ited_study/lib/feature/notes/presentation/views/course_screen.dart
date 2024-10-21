// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ited_study/core/constants/boxsize.dart';
import 'package:ited_study/core/constants/text_style.dart.dart';
import '../../../../core/route/route.dart';
import '../../domain/model/courses.dart';
import '../widgets/course_tile.dart';

class CourseScreen extends ConsumerStatefulWidget {
  const CourseScreen({super.key});

  @override
  ConsumerState<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends ConsumerState<CourseScreen> {
  List<Courses> courses = [];
  @override
  void initState() {
    getCourses();
    super.initState();
  }

  void getCourses() async {
    final box = await Hive.openBox<Courses>('courses');
    setState(() {
      courses = box.values.toList();
    });
  }

  // late Future<List<Courses>> _futureCourses;

  // @override
  // void initState() {
  //   super.initState();
  //   _futureCourses = _getCourses();
  // }

  // Future<List<Courses>> _getCourses() async {
  //   await ref.read(courseNotifierProvider.notifier).getCourses();
  //   return _getCoursesFromHive();
  // }

  // Future<List<Courses>> _getCoursesFromHive() async {
  //   final box = await Hive.openBox<Courses>('courses');
  //   return box.values.toList();
  // }

  @override
  Widget build(BuildContext context) {
    print(courses.length);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Color.fromRGBO(0, 5, 45, 1),
                  ),
                  child: Center(
                    child: Text(
                      "Courses",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      width: 1,
                      color: Color.fromRGBO(0, 5, 45, 1),
                    ),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "Completed",
                      style: TextStyle(
                        color: Color.fromRGBO(0, 5, 45, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                )
              ],
            ),
            CustomSizeBox.mediumBox,
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.push(AppRoutes.coursenote);
                      },
                      child: CustomListTile(
                        leading: Image.asset(
                          "assets/images/maths.png",
                          height: 100,
                          width: 100,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Course Title",
                              style: CustomTextStyles.secondtinyBody,
                            ),
                            Text(
                              "Mathematics",
                              style: CustomTextStyles.mediumSubtitleText,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Course Code",
                              style: CustomTextStyles.secondtinyBody,
                            ),
                            Text(
                              "Maths 101",
                              style: CustomTextStyles.mediumSubtitleText,
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(CupertinoIcons.bookmark_fill),
                            Icon(CupertinoIcons.lock_fill),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
