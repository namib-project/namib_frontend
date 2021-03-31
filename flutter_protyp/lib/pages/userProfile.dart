import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/data/user.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

// TODO This class creates a userprofile with details to edit it

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 20),
              child: Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () =>
                  {
                    saveChanges(),},
                  child: Text(
                    "Username",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // This method reopens the side after editing changes
  void saveChanges() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }

  void forwarding() {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }

  void deleteUser(User user) {
    Navigator.pushReplacementNamed(context, "/userManagement");
  }
}
