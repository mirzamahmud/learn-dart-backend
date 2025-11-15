import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:learn_dart_backend/services/task_service.dart';

FutureOr<Response> onRequest(
  RequestContext context,
  String id,
) async {
  final taskService = context.read<TaskService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getTaskById(id, taskService);
    case HttpMethod.put:
      return _updateTask(context, id, taskService);
    case HttpMethod.delete:
      return _deleteTask(id, taskService);
    default:
      return Response.json(
        statusCode: HttpStatus.methodNotAllowed,
        body: {
          'statusCode': HttpStatus.methodNotAllowed,
          'message': "Target resource doesn't support this method",
        },
      );
  }
}

/// Not Found -> Task
Future<Response> _taskNotFound(String id) async {
  return Response.json(
    statusCode: HttpStatus.notFound,
    body: {
      'statusCode': HttpStatus.notFound,
      'error': 'Resource Not Found',
      'message': 'Task with ID: $id was not found.',
    },
  );
}

/// Show Single Task -> GET /tasks/{id}
Future<Response> _getTaskById(String id, TaskService taskService) async {
  final task = taskService.getTaskById(id);
  if (task == null) return _taskNotFound(id);

  return Response.json(
    body: {
      'statusCode': HttpStatus.ok,
      'message': 'Successfully fetch task data.',
      'data': task.toJson(),
    },
  );
}

/// Edit Task -> PUT /tasks/{id}
Future<Response> _updateTask(
  RequestContext context,
  String id,
  TaskService taskService,
) async {
  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final newTitle = body['title'] != null ? body['title'] as String : null;
    final newDescription =
        body['description'] != null ? body['description'] as String : null;
    final newIsCompleted = body['isCompleted'] as bool?;

    if (newTitle == null && newIsCompleted == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'statusCode': HttpStatus.badRequest,
          'error': 'Validation Error',
          'message': 'Must provide title or isCompleted to update the task.',
        },
      );
    }

    final updatedTask =
        taskService.updateTask(id, newTitle, newDescription, newIsCompleted);

    if (updatedTask == null) return _taskNotFound(id);

    return Response.json(
      body: {
        'statusCode': HttpStatus.ok,
        'message': 'Task updated successfully.',
        'data': updatedTask.toJson(),
      },
    );
  } on ArgumentError catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'statusCode': HttpStatus.badRequest,
        'error': 'Business Logic Error',
        'message': e.message,
      },
    );
  } catch (e) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'statusCode': HttpStatus.badRequest,
        'error': 'Invalid Input',
        'message': 'Request body must be a valid JSON object.',
      },
    );
  }
}

/// Delete Task -> DELETE /tasks/{id}
Future<Response> _deleteTask(String id, TaskService taskService) async {
  final success = taskService.deleteTask(id);
  if (!success) return _taskNotFound(id);

  return Response.json(
    statusCode: HttpStatus.noContent,
    body: {
      'statusCode': HttpStatus.noContent,
      'message': 'Task deleted successfully',
    },
  );
}
