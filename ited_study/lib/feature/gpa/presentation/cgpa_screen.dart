// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ited_study/core/route/route.dart';

class CGPAScreen extends StatelessWidget {
  const CGPAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "C.G.P.A Calculator",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Calculate and keep record of your grades",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(181, 178, 178, 1),
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "0.00",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 50,
                color: Color.fromRGBO(0, 5, 45, 1),
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
            Text(
              "Total C.G.P.A",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(181, 178, 178, 1),
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "100 level",
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(0, 5, 45, 1),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "First Semester:",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 5, 45, 1),
                              ),
                            ),
                            Text(
                              '[0.00]',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 5, 45, 1),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Second Semester:",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 5, 45, 1),
                              ),
                            ),
                            Text(
                              '[0.00]',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 5, 45, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.push(AppRoutes.calculatecgpa);
                                },
                                child: Container(
                                  width: 71,
                                  height: 19,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color.fromRGBO(0, 5, 45, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Input",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 71,
                                height: 19,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(248, 6, 6, 0.9),
                                ),
                                child: Center(
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "A man that fails to plan, planned to fail. Stay focused as the sky reamins your starting point.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(1, 1, 1, 1),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: 208,
              height: 31,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Color.fromRGBO(0, 5, 45, 1),
              ),
              child: Center(
                child: Text(
                  "Calculate",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
