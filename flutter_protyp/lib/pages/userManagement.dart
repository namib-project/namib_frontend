import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_protyp/widgets/appbar.dart';
import 'package:flutter_protyp/widgets/drawer.dart';
import 'package:easy_localization/easy_localization.dart';

class UserManagement extends StatefulWidget {
  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(),
      drawer: MainDrawer(),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
              alignment: Alignment.center,
              child: SelectableText(
                'userManagement'.tr().toString(),
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                  flex: 16,
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: SelectableText("username".tr().toString()),
                      ),
                      DataColumn(
                        label: SelectableText("edit".tr().toString()),
                      ),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(SelectableText("")),
                        DataCell(IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {},
                        ))
                      ])
                    ],
                  )),
              Expanded(flex: 1, child: Container())
            ])
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
