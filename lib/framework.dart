import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './sidemenu/sidemenu.dart';
import 'models/navbar_selected_model.dart';

class Framework extends StatelessWidget{
  const Framework({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavbarTabSelectedModel>(
      create: (context) => NavbarTabSelectedModel(),
      child: Consumer<NavbarTabSelectedModel>(
        builder: (context, model, child) =>
            SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    title: Container(
                      width: 120,
                      child: Image.asset('assets/images/make_hay_logo.png')
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.black,
                  ),
                  drawer: const SideMenu(),
                  bottomNavigationBar: Material(
                    color : Colors.black,
                    child:
                    BottomNavigationBar(
                      onTap: (int _index){
                        model.currentTab = _index;
                      },
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'One',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.shopping_bag ),
                          label: 'Two',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.favorite),
                          label: 'Three',
                        ),

                      ],
                      fixedColor: Colors.white,
                      backgroundColor: Colors.black,
                      unselectedItemColor: Colors.grey[800],
                      currentIndex: (model.currentTab),
                      type: BottomNavigationBarType.fixed ,
                    ),
                  ),
                  body: model.currentScreen,
                  extendBody: true,
                )
            ),
      ),
    );
  }
}