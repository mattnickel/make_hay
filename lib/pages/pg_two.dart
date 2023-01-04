import 'package:flutter/material.dart';
import 'package:make_hay/screens/task_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';
import '../page_widgets/task_tile.dart';
import '../services/auth.dart';
import '../services/database.dart';

class Two extends StatefulWidget {
  String uid="";
  @override
  State<Two> createState() => _TwoState();
}

class _TwoState extends State<Two> {

  _getId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    widget.uid= prefs.getString("uid")!;
  }

  final AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();
    _getId().whenComplete(() {
      setState(() {});
  });
        }
  @override
  Widget build(BuildContext context) {

    return StreamProvider<Iterable<Task>>.value(
        value: DatabaseService(uid:widget.uid).tasks,
        initialData: const [],
        child:
      DefaultTabController(
          length: 3,
          child: Column(
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints.expand(height: 30),
                  width: 300,
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 10.0, bottom: 30.0),
                  child:
                  TabBar(
                    indicatorColor: const Color(0xFFC23B00),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white38,
                    isScrollable: true,
                    tabs: <Widget>[
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 130,
                          child: const Text(
                            "Active Tasks",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 170,
                          child: const Text(
                            "Completed Tasks",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )

                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: 150,
                          child: const Text(
                            "Archived Tasks",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )

                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: TabBarView(
                      children: [
                        TaskListScreen("active", widget.uid),
                        TaskListScreen("completed", widget.uid),
                        TaskListScreen("archived", widget.uid),
                        // TaskList("Completed"),
                        // TaskList("Archived"),
                      ],
                    )
                )

              ]
          )
      )
    );
  }
}