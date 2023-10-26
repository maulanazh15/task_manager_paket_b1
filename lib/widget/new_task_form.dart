import 'package:flutter/material.dart';
import 'package:task_manager_paket_b1/screens/task_detail.dart';
import 'package:task_manager_paket_b1/screens/task_list.dart';
import 'package:task_manager_paket_b1/services/task_api_services.dart';

import '../models/task.dart';

class NewTaskForm extends StatefulWidget {
  final Task? initialTask; // Task awal untuk tujuan pembaruan

  NewTaskForm({this.initialTask, Key? key}) : super(key: key);

  @override
  _NewTaskFormState createState() => _NewTaskFormState();
}

class _NewTaskFormState extends State<NewTaskForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Jika initialTask diberikan, isi input dengan informasi tugas awal (untuk tujuan pembaruan)
    if (widget.initialTask != null) {
      titleController.text = widget.initialTask!.title;
      descriptionController.text = widget.initialTask!.description;
      deadlineController.text = widget.initialTask!.deadline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialTask != null ? "Edit Tugas" : "Tambah Tugas"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              widget.initialTask != null ? 'Edit Tugas' : 'Tambah Tugas Baru',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Tugas'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Deskripsi Tugas'),
            ),
            TextField(
              controller: deadlineController,
              decoration:
                  InputDecoration(labelText: 'Tenggat Waktu (YYYY-MM-DD)'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text;
                final description = descriptionController.text;
                final deadline = deadlineController.text;

                if (title.isNotEmpty &&
                    description.isNotEmpty &&
                    deadline.isNotEmpty) {
                  final newTask = Task(
                    id: widget.initialTask != null ? widget.initialTask!.id : 0,
                    title: title,
                    description: description,
                    deadline: deadline,
                    createdAt: widget.initialTask != null
                        ? widget.initialTask!.createdAt
                        : DateTime.now(),
                    updatedAt: DateTime.now(),
                  );

                  if (widget.initialTask != null) {
                    // Jika initialTask diberikan, maka kita ingin melakukan pembaruan
                    TaskApiService.updateTask(newTask);
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => TaskDetailScreen(task: newTask,)));
                  } else {
                    // Jika tidak, maka kita menambahkan tugas baru
                    TaskApiService.createTask(newTask);
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => TaskListScreen()));
                  }

                   // Kembali ke layar sebelumnya setelah berhasil menambah/memperbarui
                }
              },
              child: Text(widget.initialTask != null
                  ? 'Simpan Perubahan'
                  : 'Tambah Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}
