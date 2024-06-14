import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Database/TaskDao.dart';
import 'package:new_app/pages/List/TaskWidget.dart';
import 'package:new_app/pages/intro_widget.dart';
import 'package:provider/provider.dart';

import '../../Provider/AuthProvidr.dart';

class ListPage extends StatelessWidget {
  static const String routeName = "listPage";

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvidr>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: IntroWidget(
                    "Get Start",
                    "assets/images/to-do-list-2 2.png",
                    'Mange your \ntime well')),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                child: Text(
                  "Calender",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
            Container(
              margin: EdgeInsets.only(left: 10, bottom: 20),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).primaryColor,
                selectedTextColor: Colors.white,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  "ToDo List",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )),
            Expanded(
                child: StreamBuilder(
                    stream: TaskDao.listenForTasks(
                        authProvider.databaseUser?.id ?? ""),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("Something went wrong  , please try again");
                      }
                      var taskList = snapshot.data;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return TaskWidget(taskList![index]);
                        },
                        itemCount: taskList?.length ?? 0,
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
