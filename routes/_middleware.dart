import 'package:dart_frog/dart_frog.dart';
import 'package:learn_dart_backend/repository/task_repository.dart';
import 'package:learn_dart_backend/services/task_service.dart';

// Create a singleton instance of the repository
final _taskRepository = TaskRepository();

// Create a singleton instance of the service, passing the repository to it
final _taskService = TaskService(_taskRepository);

Handler middleware(Handler handler) {
  return handler.use(provider<TaskService>((context) => _taskService));
}
