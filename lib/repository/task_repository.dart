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

  ///
}
