import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itai_test/model/todo_data_model.dart';
import 'package:itai_test/utils/enums.dart';
import 'package:itai_test/view/todo_user_page.dart';
import 'package:itai_test/view_model/todo_viewmodel.dart';

class TodoView extends ConsumerStatefulWidget {
  static String routeName = '/todo-page';
  const TodoView({Key? key}) : super(key: key);
  @override
  TodoViewState createState() => TodoViewState();
}

class TodoViewState extends ConsumerState<TodoView> {
  // final num _id = 0;
  @override
  void initState() {
    ref.read(todoModelProvider.notifier).getTodo();
    super.initState();
  }

  // _todoId(TodoViewModel id) {
  //   id.getTodoId(
  //     id: _id,
  //   );

  // }

  @override
  Widget build(BuildContext context) {
    final view = ref.watch(todoModelProvider);
    final model = ref.read(todoModelProvider.notifier);
    // final id = ref.read(todoModelProvider.notifier).getTodoId(id: _id);
    return Scaffold(
      body: view.isLoading == Status.loading
          ? const Align(
              alignment: Alignment.center,
              child: SizedBox(
                height: 40,
                width: 40,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            )
          : view.isLoading == Status.error
              ? TextButton(
                  onPressed: () => model.getTodo(retry: true),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${view.errorMessage}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ))
              : SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: Color.fromRGBO(0, 0, 0, 0.3),
                              offset: Offset(0, 0),
                              spreadRadius: 4,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          "todo",
                          style: GoogleFonts.lato(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 30),
                            itemCount: view.todo!.length,
                            shrinkWrap: true,
                            itemBuilder: (_, index) {
                              final todo = view.todo![index];
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          UserPageView(id: todo.id)));
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(todo.id.toString()),
                                  ),
                                  title: Text(
                                    todo.title,
                                    style: TextStyle(
                                      color: todo.completed
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
