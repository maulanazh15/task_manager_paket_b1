import 'package:flutter/material.dart';
import 'package:task_manager_paket_b1/widget/new_task_form.dart';

import '../models/task.dart';
import '../services/task_api_services.dart';
import '../widget/task_item.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  Future<List<Task>>?
      _tasksFuture; // Menggunakan Future untuk mengambil data tugas

  @override
  void initState() {
    super.initState();
    // Memulai pengambilan data tugas saat widget diinisialisasi
    _tasksFuture = TaskApiService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas'),
        leading: null,
      ),
      body: FutureBuilder<List<Task>>(
        future: _tasksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Tidak ada tugas.'),
            );
          } else {
            // Tampilkan daftar tugas
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return TaskItem(task: snapshot.data![index]);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke layar tambah tugas saat tombol ditekan
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTaskForm(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
