import 'package:flutter/material.dart';
import 'package:task_manager_paket_b1/services/task_api_services.dart';
import 'package:task_manager_paket_b1/widget/new_task_form.dart';

import '../models/task.dart';
import '../screens/task_detail.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  TaskItem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text(task.description),
        trailing: Text(
            "Deadline: ${task.deadline}"), // Konversi waktu ke zona waktu lokal
        onTap: () {
          // Navigasi ke layar detail tugas saat item tugas ditekan
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(
                        task: task,
                      )));
        },
      ),
    );
  }
}
