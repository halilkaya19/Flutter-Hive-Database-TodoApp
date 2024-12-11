import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:yuotube_tt_proje_1/data/hive_data_store.dart';
import 'package:yuotube_tt_proje_1/model/task_model.dart';
import 'package:yuotube_tt_proje_1/utils/app_string.dart';
import 'package:yuotube_tt_proje_1/views/home/components/home_appbar_components.dart';
import 'package:yuotube_tt_proje_1/views/home/components/slider_drawer.dart';
import 'package:yuotube_tt_proje_1/views/home/widget/home_floating_action_widget.dart';
import 'package:yuotube_tt_proje_1/views/home/widget/home_task_widget.dart';
import '../../utils/app_colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {


  GlobalKey<SliderDrawerState> drawerKeys = GlobalKey<SliderDrawerState>();


  int checkDoneTask(List<TaskModel> task) {
    int i = 0;
    for (TaskModel doneTasks in task) {
      if (doneTasks.isComplated) {
        i++;
      }
    }
    return i;
  }

  dynamic valueOfTheIndicator(List<TaskModel> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(

      builder: (context, Box<TaskModel> tasks, child) {
        var taskslist = tasks.values.toList();
        var counter = valueOfTheIndicator(taskslist);
        return Scaffold(
          backgroundColor: Colors.white,
          body: SliderDrawer(
            isDraggable: false,
            key: drawerKeys,
            appBar: HomeAppbarComponents(drawerKeys: drawerKeys),
            slider: SliderDrawerCustom(),
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 26),
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //ProgressBar
                            SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              value: checkDoneTask(taskslist) / valueOfTheIndicator(taskslist),
                              backgroundColor: Colors.grey,
                              valueColor:
                                  const AlwaysStoppedAnimation(MyColors.primaryColor),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.mainTitle,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Text(
                                "${checkDoneTask(taskslist)} / ${valueOfTheIndicator(taskslist)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(fontSize: 16),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Divider(
                        indent: 100,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 500,
                        child: taskslist.isNotEmpty
                            ? ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var onakiList = taskslist[index];
                                  return Dismissible(
                                    onDismissed: (_) {
                                      HiveDataSTore().deleteTask(tks: onakiList);
                                    },
                                    direction: DismissDirection.horizontal,
                                    key: Key(onakiList.id),
                                    child: HomeTaskWidget(
                                      tasks: onakiList,
                                    ),
                                  );
                                },
                                itemCount: taskslist.length,
                              )
                            : Column(
                                children: [
                                  FadeIn(
                                    duration: const Duration(milliseconds: 500),
                                    child: Lottie.asset(
                                        "assets/json/houseAni.json",
                                        animate: taskslist.isNotEmpty
                                            ? false
                                            : true),
                                  ),
                                  FadeInUp(
                                    from: 30,
                                    duration: const Duration(milliseconds: 500),
                                    child: Text(
                                      "Listeniz Boş",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                  ),
                                ],
                              ))
                  ],
                )),
          ),
          floatingActionButton: const FloatingActionWidget(),
        );
      },
      valueListenable: HiveDataSTore().allListen(),
    );
  }
}
