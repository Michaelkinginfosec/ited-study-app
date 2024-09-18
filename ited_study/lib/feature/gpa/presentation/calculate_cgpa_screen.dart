// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class CalculateCGPAScreen extends StatelessWidget {
  const CalculateCGPAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "100 Level",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromRGBO(0, 5, 45, 1),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"),
            ),
            Text(
              "Enter your grades to calculate your CGPA",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(181, 178, 178, 1),
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
            Container(
              width: double.infinity,
              height: 31,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: Color.fromRGBO(181, 178, 178, 1),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Color.fromRGBO(0, 5, 45, 1),
                      ),
                    ),
                  ),
                ],
              ),
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
              "Total C.G.P.A for first semester",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(181, 178, 178, 1),
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
