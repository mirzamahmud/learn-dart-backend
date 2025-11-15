import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:learn_dart_backend/services/task_service.dart';

FutureOr<Response> onRequest(RequestContext context) {
  /// Read the task service from the context
  final taskService = context.read<TaskService>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getAllTasks(taskService);
    case HttpMethod.post:
      return _createTask(context, taskService);
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

/// Show All Tasks -> GET /tasks
Future<Response> _getAllTasks(TaskService taskService) async {
  final tasks = taskService.getAllTasks();

  return Response.json(
    body: {
      'statusCode': HttpStatus.ok,
      'message': 'Successfully fetch tasks data',
      'data': {
        'tasks': tasks.map((task) => task.toJson()).toList(),
      },
    },
  );
}

/// Create Task -> POST /tasks
Future<Response> _createTask(
  RequestContext context,
  TaskService taskService,
) async {
  try {
    final body = await context.request.json() as Map<String, dynamic>;
    final title = body['title'] as String?;
    final description = body['description'] as String?;

    if (title == null) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'statusCode': HttpStatus.badRequest,
          'error': 'Validation Error',
          'message': 'Missing required field: title'
        },
      );
    }

    final newTask = taskService.createTask(title, description);

    return Response.json(
      statusCode: HttpStatus.created,
      body: {
        'statusCode': HttpStatus.created,
        'message': 'Task created successfully',
        'body': newTask.toJson(),
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
        'message': 'Request body must be a valid JSON object',
      },
    );
  }
}
