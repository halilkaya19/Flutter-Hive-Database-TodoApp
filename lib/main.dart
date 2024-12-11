import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yuotube_tt_proje_1/model/task_model.dart';
import 'package:yuotube_tt_proje_1/views/home/home_view.dart';


import 'data/hive_data_store.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter("uygulama");
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  Box<TaskModel> box = await Hive.openBox<TaskModel>(HiveDataSTore.boxName);
  for (var element in box.values) {
      if(element.createdAtDate.day != DateTime.now().day){
          element.delete();
      }else{

      }
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive Todo app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}

