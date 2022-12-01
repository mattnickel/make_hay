import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import '../models/task_model.dart';




class TaskTile extends StatelessWidget {
  final Task? task;
  TaskTile(this.task);
  @override
  Widget build(BuildContext context) {
    print (task?.title);
    return Stack(
        children:[
          Container(
            margin: const EdgeInsets.all(20.0),

            height:220,
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Wrap(
            children: [
              Container(
                decoration:const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black38,

                    ),
                  ),
                ),
                height:70,
                child: Row(
                  children:[
                    SizedBox(
                      width: 150,
                      child: Padding(
                        padding: EdgeInsets.only(left:40.0, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Due:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            Text(
                              "12/25/22",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.drag_indicator ), onPressed: () {
                          print("move");
                        },
                        )
                    ),
                    SizedBox(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Assigned to:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12),
                            ),
                            Text(
                              "Matt N",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration:const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black38,

                    ),
                  ),
                ),
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40.0, top:10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task?.title ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:10.0, right:40),
                          child: Text(task?.description ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )
                          ),
                        ),
                      ]
                  ),
                ),


              ),
              Row(
                children: [
                  Container(
                    decoration:const BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.black38,

                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 220,
                      child: Padding(
                        padding: EdgeInsets.only(left:40.0 ),
                        child: TextButton(
                          child: const Text(
                            "Edit",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18),

                          ),
                          onPressed: (){
                            print('Pressed');
                          },

                        ),


                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: TextButton(
                      child: const Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18),

                      ),
                      onPressed: (){
                        print('Pressed');
                      },

                    ),
                  ),
                ],
              ),
            ],
          ),


        ]);
  }
}

