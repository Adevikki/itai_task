import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itai_test/model/todo_data_model.dart';
import 'package:itai_test/model/todo_model.dart';
import 'package:itai_test/services/network_service/api_response.dart';
import 'package:itai_test/utils/constant/strings.dart';

final todoRepository = Provider((ref) => TodoRepository(Dio()));

class TodoRepository {
  const TodoRepository(this.dio);
  final Dio dio;
  Future<ApiResponse<List<Todo>>> getTodos() async {
    try {
      final response = await dio.get(
        endPointUrl,
      );
      List json = response.data;
      List<Todo> todos = json.map((e) => Todo.fromJson(e)).toList();
      return ApiResponse(
        successful: true,
        data: todos,
        message: "Data fetched successfully",
      );
    } on DioError catch (e) {
      return ApiResponse.handleError(e);
    }
  }

  Future<TodoId> getTodosById({
    num? id,
  }) async {
      final response = await dio.get(
        "https://jsonplaceholder.typicode.com/todos/$id",
      );
      var data = response.data;
      TodoId todos = TodoId.fromJson(data);
      return todos;
  }
}
