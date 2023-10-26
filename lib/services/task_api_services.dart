import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/task.dart';

class TaskApiService {
  static const String baseUrl = "https://responsi1b.dalhaqq.xyz/api";
  static const String fetchAndCreateTaskUrl = "$baseUrl/assignments";

  static String updateAndDeleteUrl(int id, bool update) {
    return update
        ? "$baseUrl/assignments/$id/update"
        : "$baseUrl/assignments/$id/delete";
  }

  static Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(fetchAndCreateTaskUrl));
    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> data = json.decode(response.body)['result'];
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Gagal mengambil daftar tugas');
    }
  }

  static Future<Task> createTask(Task newTask) async {
    final response = await http.post(
      Uri.parse(fetchAndCreateTaskUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(newTask.toJson()),
    );

    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception('Gagal menambahkan tugas');
    }
  }

  static Future<Task> updateTask(Task updatedTask) async {
    final response = await http.post(
      Uri.parse(updateAndDeleteUrl(updatedTask.id!, true)),
      headers: {"Content-Type": "application/json"},
      body: json.encode(updatedTask.toJson()),
    );

    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception('Gagal memperbarui tugas');
    }
  }

  static Future<Task> getTaskById(int taskId) async {
    final response = await http.get(Uri.parse("$baseUrl/assignments/$taskId"));

    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body)['result']);
    } else {
      throw Exception('Gagal mengambil tugas berdasarkan ID');
    }
  }

  static Future<void> deleteTask(int taskId) async {
    final response =
        await http.post(Uri.parse(updateAndDeleteUrl(taskId, false)));

    print(response.statusCode);
    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus tugas');
    }
  }
}
