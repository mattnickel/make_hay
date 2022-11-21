import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../models/task_model.dart';
import '../page_widgets/task_tile.dart';
import '../services/api_get.dart';

class TaskList extends StatefulWidget {

  String category;
  int index;

  TaskList({ required this.category, required this.index});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  var tasks;

  @override
  initState() {
    super.initState();
    tasks = fetchTasks(http.Client(), widget.category, context);
  }
  @override
  Widget build(BuildContext context) {
    return
    Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
    //     FutureBuilder<List<TaskList>>(
    //       future: tasks,
    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
    //
    //       if(snapshot.connectionState == ConnectionState.done) {
    //
    //         return snapshot.hasData
    //             ? Padding(
    //           padding: const EdgeInsets.only(top:80.0),
    //           child: Wrap(
    //               children: <Widget>[
    //
    //                 Container(
    //                     margin: const EdgeInsets.only(left: 10.0, bottom:30.0),
    //                     height: 575,
    //                     child: ListView.builder(
    //                       itemCount: 1,
    //                       itemBuilder: (context, index) {
    //                         return TaskTile(
    //                             task: snapshot.data
    //                         );
    //                       },
    //                     )
    //                 )
    //               ]
    //           ),
    //         )
    //             : const Center(child: Text("Nothing new today"));
    //
    //       }
    //       else {
    //         return Wrap(
    //             children: <Widget>[
    //               Container(
    //                   margin: const EdgeInsets.only(left: 10.0, bottom:30.0),
    //                   height: 575,
    //                   child: ListView(
    //                       scrollDirection: Axis.horizontal,
    //                       children: <Widget>[
    //                         Container(
    //                             margin: const EdgeInsets.all(10.0),
    //                             height: 550,
    //                             width: MediaQuery.of(context).size.width - 40,
    //                             child: ClipRRect(
    //                                 borderRadius: BorderRadius.circular(18.0),
    //                                 child: Shimmer.fromColors(
    //                                     baseColor: Colors.black54,
    //                                     highlightColor: Colors.black45,
    //                                     child: Container(
    //                                         color: Colors.black54
    //                                     )
    //                                 )
    //                             )
    //                         )
    //                       ]
    //                   )
    //               )
    //             ]
    //         );
    //       }
    //     }
    // ),
        Positioned(
            bottom: 160,
            right: 45,
            child: FloatingActionButton(
                backgroundColor: Color(0xFF09eebc),
                onPressed: () async {

                },
                child:
                const Icon(Icons.add, color: Colors.white)
            )
        ),
      ],
    );

  }
}