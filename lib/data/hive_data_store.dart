import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:yuotube_tt_proje_1/model/task_model.dart';

class HiveDataSTore{

    static const String boxName = "taskBox";
    final Box<TaskModel> box = Hive.box<TaskModel>(boxName);

    Future<void> addTask({required TaskModel tsk}) async{
      await box.put(tsk.id, tsk);
    }

    Future<TaskModel?> getTask({required String id}) async{
        return box.get(id);
    }

    Future<void> deleteTask({required TaskModel tks}) async{
       await  tks.delete();
    }

    Future<void> updateTask({required TaskModel tks}) async{
        await  tks.save();
    }

    ValueListenable<Box<TaskModel>> allListen() => box.listenable();


}