import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:yuotube_tt_proje_1/utils/constants.dart';

class HomeAppbarComponents extends StatefulWidget {

  const HomeAppbarComponents({required this.drawerKeys,Key? key}) : super(key: key);
  final GlobalKey<SliderDrawerState> drawerKeys;

  @override
  State<HomeAppbarComponents> createState() => _HomeAppbarComponentsState();
}

class _HomeAppbarComponentsState extends State<HomeAppbarComponents> with TickerProviderStateMixin {

  late AnimationController animationController;
  bool isDrawer = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this,duration: const Duration(microseconds: 300));
  }

  void openDrawer(){
     setState(() {
        isDrawer = !isDrawer;
        if(isDrawer){
          animationController.forward();
          widget.drawerKeys.currentState!.openSlider();
        }else{
          animationController.reverse();
          widget.drawerKeys.currentState!.closeSlider();
        }
     });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: openDrawer, icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animationController,
          ),),
          IconButton(onPressed: (){
            deleteInfoDialog(context);
          }, icon: const Icon(Icons.remove)),
        ],
      )
    );
  }
}
