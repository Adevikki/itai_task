import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:itai_test/utils/enums.dart';

import '../view_model/todo_viewmodel.dart';

class UserPageView extends ConsumerStatefulWidget {
  final num id;
  const UserPageView({super.key, required this.id});

  @override
  UserPageViewState createState() => UserPageViewState();
}

class UserPageViewState extends ConsumerState<UserPageView> {
  @override
  void initState() {
    ref.read(todoModelProvider.notifier).getTodoId(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final view = ref.watch(todoModelProvider);
    final model = ref.read(todoModelProvider.notifier);
    final todo = view.todoId;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: view.isLoading == Status.loading
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
                        onPressed: () =>
                            model.getTodoId(retry: true, id: widget.id),
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
                              child: Center(
                                child: Text(
                                  "todo details",
                                  style: GoogleFonts.lato(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          todo!.id.toString(),
                                          style: const TextStyle(fontSize: 30),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          todo.title,
                                          style: TextStyle(
                                            color: todo.completed
                                                ? Colors.grey
                                                : Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]))));
  }
}
