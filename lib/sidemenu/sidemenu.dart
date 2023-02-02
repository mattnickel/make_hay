import 'package:flutter/material.dart';
import 'package:make_hay/services/auth.dart';

class SideMenu extends StatelessWidget {
  final AuthService _auth =AuthService();

  SideMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children:<Widget>[
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