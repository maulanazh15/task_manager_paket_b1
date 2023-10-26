import 'package:flutter/material.dart';
import 'package:task_manager_paket_b1/screens/task_list.dart';
import 'package:task_manager_paket_b1/services/task_api_services.dart';
import 'package:task_manager_paket_b1/widget/new_task_form.dart';

import '../models/task.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;

  TaskDetailScreen({
    required this.task,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Tugas'),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => TaskListScreen()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Deskripsi:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(task.description),
            SizedBox(height: 10.0),
            Text(
              'Deadline:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(task.deadline), // Konversi waktu ke zona waktu lokal
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewTaskForm(
                                  initialTask: task,
                                )));
                  },
                  child: Text('Update'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Hapus Tugas'),
                          content:
                              Text('Anda yakin ingin menghapus tugas ini?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pop(); // Tutup dialog konfirmasi
                              },
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Panggil fungsi onDelete untuk menghapus tugas
                                TaskApiService.deleteTask(task.id!);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => TaskListScreen())); // Tutup dialog konfirmasi
                              },
                              child: Text('Hapus'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
