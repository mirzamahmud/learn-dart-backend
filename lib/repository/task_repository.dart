import 'package:learn_dart_backend/core/extensions/null_extension.dart';
import 'package:learn_dart_backend/models/task.dart';
import 'package:uuid/uuid.dart';

/// Task Repository
class TaskRepository {
  final List<Task> _tasks = [];
  final Uuid _uiId = const Uuid();

  /// Read All Tasks
  List<Task> getAllTasks() => _tasks;

  /// Read Single Task
  Task? getTaskById(String id) {
    return _tasks.firstWhereOrNull((task) => task.id == id);
  }

  /// Create new task
  Task createTask(String title, String? description) {
    final task = Task(id: _uiId.v4(), title: title, description: description);
    _tasks.add(task);

    return task;
  }

  /// Update existing task
  Task? updateTask(
    String id,
    String? newTitle,
    String? newDescription,
    bool? newIsCompleted,
  ) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex == -1) return null;

    final existingTask = _tasks[taskIndex];

    if (newTitle != null) {
      existingTask.title = newTitle;
    }

    if (newDescription != null) {
      existingTask.description = newDescription;
    }

    if (newIsCompleted != null) {
      existingTask.isCompleted = newIsCompleted;
    }

    return existingTask;
  }

  /// Delete Task
  bool deleteTask(String id) {
    final beforeLength = _tasks.length;
    _tasks.removeWhere((task) => task.id == id);

    return _tasks.length < beforeLength;
  }
}
