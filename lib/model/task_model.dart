import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)

class TaskModel extends HiveObject{
    
    @HiveField(1)
    final String id;
    @HiveField(2)
    String title;
    @HiveField(3)
    String subTitle;
    @HiveField(4)
    DateTime createdAtTime;
    @HiveField(5)
    DateTime createdAtDate;
    @HiveField(6)
    bool isComplated;

    TaskModel({required this.id,required this.title,required this.subTitle,required this.createdAtTime,required this.createdAtDate,required this.isComplated});
    
    factory TaskModel.created({String? id,String? title,String? subTitle,DateTime? c,DateTime? d}){
        return TaskModel(id: const Uuid().v4(), title: title ?? '', subTitle: subTitle ?? '', createdAtTime: c ?? DateTime.now(), createdAtDate: d ?? DateTime.now(), isComplated: false);
    }
    
}