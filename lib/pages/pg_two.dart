import 'package:flutter/material.dart';
import 'package:make_hay/screens/task_list.dart';

import '../page_widgets/task_tile.dart';



class Two extends StatelessWidget {
  const Two({super.key});

  @override

  Widget build(BuildContext context) {
    return
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
                        TaskTile(),
                        TaskList(),
                        TaskList(),
                        // TaskList("Completed"),
                        // TaskList("Archived"),
                      ],
                    )
                )

              ]
          )
      );
  }

  void doSomething() {}
}