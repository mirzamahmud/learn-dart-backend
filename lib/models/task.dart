/// Task Model
class Task {
  /// Constractor
  Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
  });

  /// Factory constructor to create a Task from a JSON map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description:
          json['description'] != null ? json['description'] as String : null,
      isCompleted: json['is_completed'] as bool,
    );
  }

  /// Convert the Task object to a JSON map
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted
    };
  }

  /// Task id
  final String id;

  /// Task title
  final String title;

  /// Task description (optional)
  final String? description;

  /// Check task is completed or not
  final bool isCompleted;

  /// Copy With Method
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
