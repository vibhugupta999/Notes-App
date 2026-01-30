import 'package:flutter/material.dart';

PreferredSizeWidget appBar(
  BuildContext ctx,
  String title,
  IconData? icon,
  VoidCallback? onpressed,
) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(ctx).textTheme.bodyMedium!.color,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: Theme.of(ctx).textTheme.titleLarge!.fontFamily,
      ),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(ctx).primaryColor,
    actions: [
      IconButton(
        onPressed: onpressed,
        icon: Icon(
          icon,
          color: Theme.of(ctx).textTheme.headlineMedium!.color,
          size: 28,
        ),
      ),
    ],
  );
}
