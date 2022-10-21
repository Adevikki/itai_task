import 'dart:convert';

TodoId todoFromJson(String str) => TodoId.fromJson(json.decode(str));

String todoToJson(TodoId data) => json.encode(data.toJson());

class TodoId {
    TodoId({
         this.userId,
         this.id,
         this.title,
         this.completed,
    });

    num? userId;
    num? id;
    String? title;
    bool? completed;

    factory TodoId.fromJson(Map<String, dynamic> json) => TodoId(
        userId: json["userId"] ?? 0,
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
        completed: json["completed"] ?? false,
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
    };
}

