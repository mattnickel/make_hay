import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {

  const SideMenu({super.key});
  // Function _doSomething(){}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children:<Widget>[
          ListTile(
            leading: const Icon(Icons.portrait_rounded),
            title: const Text("Profile"),
            onTap: (){
              // _doSomething();
              Navigator.pop(context);
            },
          ),
          const ListTile(
            leading: Icon(Icons.circle_notifications),
            title: Text("Notifications"),
          ),
          const ListTile(
            leading: Icon(Icons.hail),
            title: Text('Payment Info'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),

        ],
      ) ,
    );
  }
}