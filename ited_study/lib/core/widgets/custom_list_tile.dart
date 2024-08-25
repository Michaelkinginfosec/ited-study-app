// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget subTitle;
  final Widget title;
  final Widget icon;

  const CustomListTile({
    super.key,
    required this.subTitle,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        trailing: icon,
        title: title,
        subtitle: subTitle,
      ),
    );
  }
}
