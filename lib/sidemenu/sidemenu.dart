import 'package:flutter/material.dart';
import 'package:make_hay/services/auth.dart';

class SideMenu extends StatelessWidget {

  final AuthService _auth =AuthService();

  // Function _doSomething(){}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children:<Widget>[
          // ListTile(
          //   leading: const Icon(Icons.portrait_rounded),
          //   title: const Text("Profile",
          //     style: TextStyle(
          //         color:Colors.black54
          //     ),),
          //   onTap: () async {
          //     await _auth.signOut();
          //   },
          // ),
          // const ListTile(
          //   leading: Icon(Icons.circle_notifications),
          //   title: Text(
          //       "Notifications",
          //       style: TextStyle(
          //         color:Colors.black54
          //       ),
          //   ),
          // ),
          // const ListTile(
          //   leading: Icon(Icons.hail),
          //   title: Text('Payment Info',
          //     style: TextStyle(
          //         color:Colors.black54
          //     ),),
          // ),
          Padding(
            padding: const EdgeInsets.only(top:20.0),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.white,),
              title: const Text('Logout',
                style: TextStyle(
                    color:Colors.white
                ),
              ),
              onTap: () async {
                await _auth.signOut();
              },
            ),
          ),

        ],
      ) ,
    );
  }
}