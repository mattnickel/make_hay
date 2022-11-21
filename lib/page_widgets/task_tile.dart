import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/task_model.dart';




class TaskTile extends StatelessWidget {


Task task;

  TaskTile({ required this.task});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          height: 550,
          width: MediaQuery.of(context).size.width - 40,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child:
                Column(
                  children: <Widget>[
                      Row(
                      children: [
                        Positioned(
                          top: 20,
                          right:20,
                          child: Text(task.title)
                        ),
                        Positioned(
                            top: 20,
                            right:20,
                            child: Text(task.description)
                        ),
                  ]
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}

