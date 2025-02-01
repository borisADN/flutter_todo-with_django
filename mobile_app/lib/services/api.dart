
import 'package:dio/dio.dart';
import 'package:mobile_app/models/task.dart';

class ApiService {
  final Dio _dio = Dio(
     BaseOptions(
    baseUrl: 'http://192.168.1.77:8000',
    headers: {
      'content-type': 'application/json',
    }
  )
  );

  Future<List<TaskModel>> getTask() async {
    try {
      final response = await _dio.get('/todo/tasks');
      if (response.statusCode == 200) {
        // final data = jsonDecode(response.data);
        return (response.data as List).map((task) => TaskModel.fromJson(task)).toList();
      } else {
        throw Exception('Failed to get tasks');
      }
    } catch (error) {
      throw Exception('Failed to get tasks: $error');
    }
  }

  //add task
  Future<void> addTask(TaskModel task) async {
    try {
      final response = await _dio.post('/todo/tasks/', data: task.toJson());
      if (response.statusCode == 201) {
        print('Task added successfully');
      } else {
        throw Exception('Failed to add task');
      }
    } catch (error) {
      throw Exception('Failed to add task: $error');
    }
  }

  //update task
  Future<void> updateTask(TaskModel task) async {
    try {
      final response = await _dio.put('/todo/tasks/${task.id}', data: task.toJson());
      if (response.statusCode == 200) {
        print('Task updated successfully');
      } else {
        throw Exception('Failed to update task');
      }
    } catch (error) {
      throw Exception('Failed to update task: $error');
    }
  }

  //delete task
Future<void> deleteTask(TaskModel task) async {
  try {
    print('Deleting task with ID: ${task.id}');  // Log avant la requête
    // final response = await _dio.delete('/todo/tasks/${task.id}/');
    await _dio.delete('/todo/tasks/${task.id}/');
    // print('Response: ${response.statusCode}, ${response.data}');  // Log de la réponse
  } catch (error) {
    print('Error: $error');  // Log de l'erreur
    throw Exception('Failed to delete task: $error');
  }
}


 
}
