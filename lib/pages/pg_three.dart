import 'package:flutter/material.dart';
import 'package:make_hay/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../popups/beta_popup.dart';


class Three extends StatefulWidget {

  const Three({super.key});

  @override
  State<Three> createState() => _ThreeState();
}

class _ThreeState extends State<Three> {
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
      Container(
        padding: const EdgeInsets.only(left: 40.0, right: 40.0, top:20.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Icon(Icons.lock_rounded,
                size: 128,
                color: Colors.white70,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("This is a ",
                style: TextStyle(
                    fontSize: 18,),),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0.0),
              child: Text("Premium Feature",
                style: TextStyle(
                  fontSize: 28,),),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text("The ability to delegate tasks and work as a team is what makes this app so powerful. To unlock the full potential of this app, a premium team subscription is required. Premium Features include:"
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text(" • Abilty to join as part of a team"
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(" • Visibility of tasks between team members"
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(" • Delegation of tasks by team members"
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("For more information about premium team subscriptions, click the button below and someone will reach out to setup a premium team account."

              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Team Subscriptions starting at \$9.99/ month"

              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top:40.0),
              child: ElevatedButton(
              onPressed: () async {
                    // Navigator.of(context).pop();
                DatabaseService(uid:uid).createInterested();
                await showDialog(
                    context:context,
                    builder:(BuildContext context){
                      return betaPopup(context);
                    }
                );
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC23B00),
                  padding: const EdgeInsets.symmetric(vertical:15),
                  elevation: 0.2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                ),
              child: const Text("Yes. I'm interested!", style: TextStyle(color: Colors.white, fontSize: 16)
              ),

              ),
            ),
          ],
        ));
  }
}