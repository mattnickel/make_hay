import 'package:flutter/material.dart';
import 'package:make_hay/services/database.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/quote_model.dart';
import '../models/task_model.dart';
import '../screen_widgets/task_list.dart';
import '../screens/task_list_screen.dart';
import '../services/api_get.dart';



class One extends StatefulWidget {
  One({super.key});


  @override
  State<One> createState() => _OneState();
}

class _OneState extends State<One> {
  late Quote quote;
  late String uid="";
  _getId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid= prefs.getString("uid")!;
  }
  @override
  void initState() {
    super.initState();
    _getId();
  }
  @override
  Widget build(BuildContext context){

    return
      ListView(
          children:  [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 180.0,
              ),
              child: FutureBuilder <Quote?>(
                future: callQuotesApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      quote = snapshot.data as Quote;
                      return

                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 60.0, bottom: 20, left: 30, right: 30),
                              child: Text("\"${quote.text}\"",
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width - 40,
                              padding: const EdgeInsets.all(8.0),
                              child: Text("- ${quote.author}",
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        );
                    }else{
                      return Container();
                    }
                     const Text("Nothing to show");
                  } else{
                     return Container();
                }
              }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: const Text("Due Today",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500),),
              ),
            ),
            StreamProvider<List<Task>>.value(
              value: DatabaseService(uid:uid).todayTasks,
              initialData: const [],
              child: TaskList("active", uid),
            ),

          ]
        );
  }



}

