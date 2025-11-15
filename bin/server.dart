// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/tasks/index.dart' as tasks_index;
import '../routes/tasks/[id].dart' as tasks_$id;

import '../routes/_middleware.dart' as middleware;

void main() async {
  final address = InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  createServer(address, port);
}

Future<HttpServer> createServer(InternetAddress address, int port) async {
  final handler = Cascade().add(buildRootHandler()).handler;
  final server = await serve(handler, address, port);
  print('\x1B[92m✓\x1B[0m Running on http://${server.address.host}:${server.port}');
  return server;
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/tasks', (context) => buildTasksHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildTasksHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => tasks_index.onRequest(context,))..all('/<id>', (context,id,) => tasks_$id.onRequest(context,id,));
  return pipeline.addHandler(router);
}

