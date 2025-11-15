import 'package:learn_dart_backend/models/task.dart';
import 'package:learn_dart_backend/repository/task_repository.dart';

/// The TaskService handles the application's business logic.
/// It uses the TaskRepository to interact with the data.
class TaskService {
  /// The service depends on the repository (Dependency Injection)
  TaskService(this._repository);

  final TaskRepository _repository;

  /// ------------------------
  /// Read Operations
  /// ------------------------
  List<Task> getAllTasks() {
    final tasks = _repository.getAllTasks()
      ..sort(
        (a, b) => a.isCompleted == b.isCompleted
            ? 0
            : a.isCompleted
                ? 1
                : -1,
      );
    return tasks;
  }

  /// ----------------------
  /// Read Single Task
  /// ----------------------
  Task? getTaskById(String id) {
    return _repository.getTaskById(id);
  }

  /// -------------------
  /// Create Operation
  /// -------------------
  Task createTask(String title, String? description) {
    // Business logic example: Ensure the title is trimmed and not empty
    final cleanTitle = title.trim();
    final cleanDescription = description?.trim();

    if (cleanTitle.isEmpty) {
      throw ArgumentError('Task title cannot be empty.');
    }
    return _repository.createTask(cleanTitle, cleanDescription);
  }

  /// -------------------
  /// Update Operation
  /// -------------------
  Task? updateTask(
    String id,
    String? newTitle,
    String? newDescription,
    bool? newIsCompleted,
  ) {
    final existingTask = _repository.getTaskById(id);
    if (existingTask == null) {
      return null; // Task not found
    }

    // Business logic example: If a new title is provided, clean it
    String? titleToUse;
    String? descriptionToUse;

    if (newTitle != null) {
      titleToUse = newTitle.trim();
      if (titleToUse.isEmpty) {
        titleToUse = null;
      }
    }

    if (newDescription != null) {
      descriptionToUse = newDescription.trim();
      if (descriptionToUse.isEmpty) {
        descriptionToUse = null;
      }
    }

    // Delegate the actual data change to the repository
    return _repository.updateTask(
      id,
      titleToUse,
      descriptionToUse,
      newIsCompleted,
    );
  }

  /// -------------------
  /// Delete Operation
  /// -------------------
  bool deleteTask(String id) {
    return _repository.deleteTask(id);
  }
}
