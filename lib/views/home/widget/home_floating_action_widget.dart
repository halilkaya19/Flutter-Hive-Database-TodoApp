import 'package:flutter/material.dart';
import 'package:yuotube_tt_proje_1/views/tasks/task_view.dart';
class FloatingActionWidget extends StatelessWidget {
  const FloatingActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TaskView(descriptionController: null,task: null,titleTaskController: null),));
      },
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 10,
        child: Container(
          width: 64,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
