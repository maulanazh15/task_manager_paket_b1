import 'package:flutter/material.dart';

import '../models/task.dart';
import '../screens/task_detail.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
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
