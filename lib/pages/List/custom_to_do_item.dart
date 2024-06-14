import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:new_app/core/helper/api.dart';
import 'package:new_app/pages/List/update_task_modal.dart';

class CustomToDoItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String time;

  const CustomToDoItem({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the time from the API and convert it to local time
    final DateTime utcTime = DateTime.parse(time).toUtc();
    final DateTime localTime = utcTime.toLocal();

    // Format the local time as 12-hour time
    final String formattedTime = DateFormat.jm().format(localTime);

    return Dismissible(
      key: Key(id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) async {
        try {
          await ApiService.deleteTask(id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task deleted')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete task: $e')),
          );
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.13,
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 62,
              decoration: ShapeDecoration(
                color: const Color(0xFF5D9CEC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF50A7FF),
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      letterSpacing: 0.27,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(IconlyLight.discovery, size: 16),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          formattedTime,
                          style: const TextStyle(
                            color: Color(0xFF363636),
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.2,
                            letterSpacing: 0.18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _showEditModalBottomSheet(context);
              },
              child: Container(
                width: 69,
                height: 34,
                decoration: ShapeDecoration(
                  color: const Color(0xFF50A7FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.penToSquare,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskModal(
          id: id,
          title: title,
          description: description,
        );
      },
    );
  }
}
