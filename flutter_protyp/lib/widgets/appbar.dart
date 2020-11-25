import 'package:flutter/material.dart';
import "package:flutter_protyp/widgets/constant.dart";

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: AppBar(
      backgroundColor: primaryColor,
      title: Text("NAMIB"),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(12),
          child: RaisedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/login");
            },
            padding: EdgeInsets.all(0),
            child: Text("Logout"),
            color: buttonColor,
          ),
        ),
      ],
    ));
  }

  @override
  Size get preferredSize {
    return new Size.fromHeight(kToolbarHeight);
  }
}
