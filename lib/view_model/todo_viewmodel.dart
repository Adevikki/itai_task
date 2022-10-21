import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itai_test/model/todo_data_model.dart';
import 'package:itai_test/model/todo_model.dart';
import 'package:itai_test/services/todo_service.dart';
import 'package:itai_test/utils/enums.dart';

final todoModelProvider = StateNotifierProvider<TodoViewModel, TodoViewState>(
  (ref) => TodoViewModel(ref),
);

class TodoViewModel extends StateNotifier<TodoViewState> {
  TodoViewModel(this._ref) : super(TodoViewState.initial());
  final Ref _ref;

  Future<void> getTodo({
    bool retry = false,
  }) async {
    if (retry) {
      state = state.copyWith(isLoading: Status.loading);
    }

    try {
      final response = await _ref.read(todoRepository).getTodos();
      if (response.successful) {
        state = state.copyWith(isLoading: Status.loaded, todo: response.data);
        return;
      }
      state =
          state.copyWith(isLoading: Status.error, errorMessage: response.error);
    } catch (e) {
      // debugLog(e);
      state =
          state.copyWith(isLoading: Status.error, errorMessage: e.toString());
    }
  }

  Future<void> getTodoId({
    num? id,
    bool retry = false,
  }) async {
    if (retry) {
      state = state.copyWith(isLoading: Status.loading);
    }
    try {
      final response = await _ref.read(todoRepository).getTodosById(
            id: id,
          );
      if (response.successful) {
        state = state.copyWith(
          isLoading: Status.loaded,
          todoId: response.data,
        );
        return;
      }
      state = state.copyWith(
        isLoading: Status.error,
        errorMessage: response.error,
      );
      return;
    } catch (e) {
      state = state.copyWith(
        isLoading: Status.error,
        errorMessage: e.toString(),
      );
    }
  }
}

class TodoViewState {
  final List<Todo>? todo;
  final TodoId? todoId;
  final Status isLoading;
  final String? errorMessage;
  TodoViewState(
      {this.todoId, this.todo, required this.isLoading, this.errorMessage});

  factory TodoViewState.initial() => TodoViewState(
        isLoading: Status.loading,
        todo: const [],
        todoId: TodoId(),
      );
  TodoViewState copyWith({
    List<Todo>? todo,
    TodoId? todoId,
    Status? isLoading,
    String? errorMessage,
  }) {
    return TodoViewState(
      todo: todo ?? this.todo,
      todoId: todoId ?? this.todoId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
