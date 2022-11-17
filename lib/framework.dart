import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
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
                    title: SizedBox(
                      width: 120,
                      child: Image.asset('assets/images/make_hay_logo.png')
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.black,
                  ),
                  drawer: const SideMenu(),
                  bottomNavigationBar: Container(
                    height: 70,
                    margin: const EdgeInsets.only(bottom: 20, left: 20, right:20),
                    // padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),

                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: FloatingNavbar(
                        onTap: (int index){
                          model.currentTab = index;
                        },
                        backgroundColor: Colors.white,
                        borderRadius: 100,
                        selectedItemColor: const Color(0xFFC23B00),
                        selectedBackgroundColor: null,
                        unselectedItemColor: Colors.black54,
                        currentIndex: (model.currentTab),
                        items: [
                          FloatingNavbarItem(icon: Icons.calendar_today, title: 'For Today', ),
                          FloatingNavbarItem(icon: Icons.list_alt_outlined, title: 'Task List'),
                          FloatingNavbarItem(icon: Icons.group, title: 'Delegate'),

                        ],
                      ),
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