import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:new_app/core/helper/api.dart';
import 'package:new_app/pages/List/custom_to_do_item.dart';
import 'package:new_app/pages/intro_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});
  static const String routeName = "listPage";

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String userName = "";

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('currentUserName') ?? 'User';
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To Do'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: ApiService.getAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                CustomToDoState(userName: userName),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                CustomToDoState(userName: userName),
                const Center(child: Text('Error: Please try later!')),
              ],
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomToDoState(userName: userName),
                const Center(
                  child: Text('No tasks available'),
                ),
              ],
            );
          } else {
            final tasks = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomToDoState(userName: userName),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: CustomToDoItem(
                          id: task['_id'],
                          title: task['title'],
                          description: task['description'],
                          time: task['createdAt'],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CustomToDoState extends StatelessWidget {
  const CustomToDoState({
    super.key,
    required this.userName,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi, $userName",
            style: const TextStyle(color: Colors.black45, fontSize: 18),
          ),
          Text(
            "Smart Mood",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 24,
                fontWeight: FontWeight.w800),
          ),
          IntroWidget("Get Start", "assets/images/to-do-list-2 2.png",
              'Manage your \ntime well'),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Text(
              "Calendar",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: Theme.of(context).primaryColor,
              selectedTextColor: Colors.white,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
