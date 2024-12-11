import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:yuotube_tt_proje_1/data/hive_data_store.dart';
import 'package:yuotube_tt_proje_1/model/task_model.dart';
import 'package:yuotube_tt_proje_1/utils/constants.dart';
import 'package:yuotube_tt_proje_1/views/tasks/widget/task_view_appbar.dart';

class TaskView extends StatefulWidget {
  const TaskView(
      {required this.descriptionController,
      required this.titleTaskController,
      required this.task,
      Key? key})
      : super(key: key);
  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionController;
  final TaskModel? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {

  var title;
  var subtitle;
  DateTime? time;
  DateTime? date;

  bool isTaskAlreadyExistBool() {
    if (widget.titleTaskController?.text == null &&
        widget.descriptionController?.text == null) {
      return true;
    } else {
      return false;
    }
  }

  dynamic isTaskAlreadyExistUpdateTask() {

    var database = HiveDataSTore();

    if (widget.titleTaskController?.text != null &&
        widget.descriptionController?.text != null) {
      try {
        widget.descriptionController?.text = title;
        widget.descriptionController?.text = subtitle;

        // widget.task?.createdAtDate = date!;
        // widget.task?.createdAtTime = time!;
        widget.task?.save();
        Navigator.of(context).pop();
      } catch (error) {
        emptyUpdateTask(context);
      }
    } else {
      if (title != null && subtitle != null) {
        var task = TaskModel.created(
          title: title,
          c: time,
          d: date,
          subTitle: subtitle,
        );
        database.addTask(tsk: task);
        Navigator.of(context).pop();
      } else {
        emptyUpdateTask(context);
      }
    }
  }

  /// Delete Selected Task
  dynamic deleteTask() {
    return widget.task?.delete();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const TaskViewAppbar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _sizeTopbar(context),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Column(
                    children: [
                      TextFieldAddWidget(
                        controller: widget.titleTaskController,
                        isForDescription: true,
                        onChanched: (String data) {
                          title = data;
                        },
                        onFieldSubmit: (String data) {
                          title = data;
                        },
                      ),
                      TextFieldAddWidget(
                        controller: widget.descriptionController,
                        isForDescription: false,
                        onChanched: (String data1) {
                          subtitle = data1;
                        },
                        onFieldSubmit: (String data1) {
                          subtitle = data1;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Saat"),
                            ),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showTimePicker(context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    onChanged: (_) {},
                                    onConfirm: (selectedTime) {
                                      setState(() {
                                        if (widget.task?.createdAtTime == null) {
                                          time = selectedTime;
                                        }else{
                                          widget.task?.createdAtTime = selectedTime;
                                        }
                                      });
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade400),
                                child: const Center(
                                  child:  Text("Zaman"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(10),
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding:EdgeInsets.all(8.0),
                              child: Text("Tarih"),
                            ),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showTimePicker(context,
                                    showTitleActions: true,
                                    showSecondsColumn: false,
                                    onChanged: (_) {},
                                    onConfirm: (selectedTime) {
                                      setState(() {
                                        if (widget.task?.createdAtDate == null) {
                                           time = selectedTime;
                                        }else{
                                            widget.task?.createdAtDate = selectedTime;
                                        }
                                      });
                                  });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade400),
                                child: const Center(
                                  child: Text("Zaman"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 15),
                        child: Row(
                          children: [
                            MaterialButton(
                              minWidth: 130,
                              height: 50,
                              onPressed: () {
                                deleteTask();
                              },
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.red,
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Delete Task"),
                                  Icon(Icons.remove_circle_outline),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            MaterialButton(
                              minWidth: 130,
                              height: 50,
                              onPressed: () {
                                isTaskAlreadyExistUpdateTask();
                              },
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.green,
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Add Task"),
                                  Icon(Icons.add),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sizeTopbar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Row(
        children: [
          const SizedBox(
            width: 80,
            child: Divider(
              thickness: 2,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          RichText(
            text: TextSpan(
                text: isTaskAlreadyExistBool() ? "Add News Task" : "Update",
                style: Theme.of(context).textTheme.headlineSmall),
          )
        ],
      ),
    );
  }
}

class TextFieldAddWidget extends StatelessWidget {
  const TextFieldAddWidget(
      {
        required this.controller,
        this.isForDescription = false,
        Key? key,
        required this.onFieldSubmit,
        required this.onChanched})
      : super(key: key);

  final TextEditingController? controller;
  final bool isForDescription;
  final Function(String)? onFieldSubmit;
  final Function(String)? onChanched;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: isForDescription ? const Icon(Icons.add) : null,
          hintText: isForDescription ? "new task" : 'Note',
        ),
        maxLines: isForDescription ? 6 : 2,
        cursorHeight: 56,
        onFieldSubmitted: onFieldSubmit,
        onChanged: onChanched,
      ),
    );
  }
}
