import 'dart:developer';

import 'package:flutter/material.dart';

class SliderDrawerCustom extends StatelessWidget {

  SliderDrawerCustom({Key? key}) : super(key: key);

  final List<String> menuItems = ["Anasayfa","profil","ayarlar","iletişim"];
  final List<Widget> menuIcons= [const Icon(Icons.home),const Icon(Icons.usb_off_rounded),const Icon(Icons.settings),const Icon(Icons.close)];


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 40),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue,Colors.black26],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(maxRadius: 80,minRadius: 80),
            const SizedBox(height:20,),
            const Text("Flutter Developer"),
            const Text("Halil İbrahim kaya"),
            SizedBox(
              width: double.infinity,
              height: 300,
              child: ListView.builder(itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      log("Menu Items");
                    },
                    leading: menuIcons[index],
                    title: Text(menuItems[index],style: const TextStyle(color: Colors.white),),
                  );
              },itemCount: menuItems.length),
            )
          ],
        ),
    );
  }
}
