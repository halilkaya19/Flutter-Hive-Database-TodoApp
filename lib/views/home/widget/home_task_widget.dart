import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yuotube_tt_proje_1/model/task_model.dart';
import 'package:yuotube_tt_proje_1/utils/app_colors.dart';
import 'package:yuotube_tt_proje_1/views/tasks/task_view.dart';

class HomeTaskWidget extends StatefulWidget {

  const HomeTaskWidget({required this.tasks, Key? key}) : super(key: key);
  final TaskModel tasks;

  @override
  State<HomeTaskWidget> createState() => _HomeTaskWidgetState();

}

class _HomeTaskWidgetState extends State<HomeTaskWidget> {

  TextEditingController TextEditingControllerforTitle = TextEditingController();
  TextEditingController TextEditingControllerforSubtitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    TextEditingControllerforTitle.text = widget.tasks.title;
    TextEditingControllerforSubtitle.text = widget.tasks.subTitle;
  }

  @override
  void dispose() {
    TextEditingControllerforTitle.dispose();
    TextEditingControllerforSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
            TaskView(
                descriptionController: TextEditingControllerforTitle,
                titleTaskController: TextEditingControllerforSubtitle,
                task: widget.tasks),));
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.tasks.isComplated ? MyColors.primaryColor.withOpacity(
                0.3) : Colors.grey
        ),
        duration: const Duration(milliseconds: 330),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              setState(() {
                widget.tasks.isComplated = !widget.tasks.isComplated;
                widget.tasks.save();
              });
            },
            child: AnimatedContainer(
              duration: const Duration(microseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.tasks.isComplated ? MyColors.primaryColor : Colors
                    .white,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 26,),
            ),
          ),
          title: Text(TextEditingControllerforTitle.text, style: TextStyle(
              decoration: widget.tasks.isComplated
                  ? TextDecoration.lineThrough
                  : null),),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.tasks.subTitle),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(DateFormat("hh:mm a").format(widget.tasks.createdAtTime)),
              Text(DateFormat.yMMMd().format(widget.tasks.createdAtDate)),
            ],
          ),
        ),
      ),
    );
  }
}
