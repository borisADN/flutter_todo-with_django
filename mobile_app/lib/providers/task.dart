import 'package:flutter/material.dart';
import 'package:mobile_app/models/task.dart';
import 'package:mobile_app/services/api.dart';

class TaskProvider with ChangeNotifier{
 final ApiService _apiService = ApiService();
 List <TaskModel> _tasks = [];

 List<TaskModel> get tasks => _tasks;

 Future<void> fetchTasks() async {
   _tasks = await _apiService.getTask();
   notifyListeners();
 }

 void addTask(TaskModel task) async {
   await _apiService.addTask(task);
   _tasks.add(task);
   fetchTasks();
 }

 void updateTask(TaskModel updatedTask) async {
   await _apiService.updateTask(updatedTask);
  //  final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
  //  if (index != -1) {
  //    _tasks[index] = updatedTask;
  //    notifyListeners();
  //  }
     fetchTasks();
 }

 void deleteTask(TaskModel task) async {
   await _apiService.deleteTask(task);
  fetchTasks();
 }
}