import 'package:learn_dart_backend/models/task.dart';

/// Extension to mimic Dart's `firstWhereOrNull`
extension NullExtension on List<Task> {
  /// First Where or null method
  Task? firstWhereOrNull(bool Function(Task) task) {
    try {
      return firstWhere(task);
    } catch (_) {
      return null;
    }
  }
}
