import 'package:flutter/material.dart';
class TaskViewAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskViewAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20),
            child: IconButton(onPressed: (){
              Navigator.of(context).pop();
            }, icon: const Icon(Icons.arrow_back_ios))
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(40);
}
