import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_app/Database/Model/task.dart';
import 'package:new_app/Database/TaskDao.dart';
import 'package:new_app/Provider/AuthProvidr.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  TextEditingController Title = TextEditingController();

  TextEditingController Descripation = TextEditingController();

  TaskWidget(this.task, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask();
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            label: 'Delete',
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          )
        ],
        motion: DrawerMotion(),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 64,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      widget.task.title ?? '',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Text(widget.task.description ?? ""),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 21,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const ImageIcon(
                AssetImage("assets/images/icon_check.png"),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Accept"),
          content: const Text('Are you sure to delete task ? '),
          actions: [
            CupertinoDialogAction(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text("Yes"),
              onPressed: () {
                deleteFromFirestore();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void deleteFromFirestore() async {
    var authProvider = Provider.of<AuthProvidr>(context, listen: false);
    await TaskDao.removeTask(widget.task.id!, authProvider.databaseUser!.id!);
  }
}
