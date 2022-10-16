
import 'package:demo/studentdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/student_bloc.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is DisplayStudents) {
          final students = state.students;
          return ListView.separated(
              itemBuilder: ((context, index) {
                final value = students[index];
                if (value.name.toLowerCase().contains(query.toLowerCase())) {
                  return Card(
                    shadowColor: Colors.black38,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: const Color.fromARGB(255, 200, 200, 200),
                    child: GestureDetector(
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentDetail(valueee: index),
                            ));
                      },
                      child: ListTile(
                        leading: Text(value.name),
                        trailing: IconButton(
                            onPressed: () {
                              context
                                  .read<StudentBloc>()
                                  .add(DeleteStudent(id: students[index].id!));
                              context
                                  .read<StudentBloc>()
                                  .add(const FetchStudents());
                              // DatabaseHelper.instance.remove(value.id!);
                              // DatabaseHelper.instance.refresh();
                              alerted(context);
                            },
                            icon: const Icon(Icons.delete_outline_outlined),
                            color: const Color.fromARGB(255, 113, 48, 44)),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 1,
                  );
                }
              }),
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              itemCount: students.length);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        if (state is DisplayStudents) {
          final students = state.students;
          return ListView.separated(
              itemBuilder: ((context, index) {
                final value = students[index];
                if (value.name.toLowerCase().contains(query.toLowerCase())) {
                  return Card(
                    shadowColor: Colors.black38,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: const Color.fromARGB(255, 200, 200, 200),
                    child: GestureDetector(
                      onLongPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentDetail(valueee: index),
                            ));
                      },
                      child: ListTile(
                        leading: Text(value.name),
                        trailing: IconButton(
                            onPressed: () {

                              context
                                  .read<StudentBloc>()
                                  .add(DeleteStudent(id: students[index].id!));
                              context
                                  .read<StudentBloc>()
                                  .add(const FetchStudents());

                              // DatabaseHelper.instance.remove(value.id!);
                              // DatabaseHelper.instance.refresh();
                              alerted(context);
                            },
                            icon: const Icon(Icons.delete_outline_outlined),
                            color: const Color.fromARGB(255, 113, 48, 44)),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(
                    height: 1,
                  );
                }
              }),
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
              itemCount: students.length);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: const Color.fromARGB(255, 200, 200, 200),
    );
  }

  alerted(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Deleted'),
        backgroundColor: const Color.fromARGB(255, 108, 17, 10),
        duration: const Duration(milliseconds: 800),
        dismissDirection: DismissDirection.horizontal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
    );
  }
}
