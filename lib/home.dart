import 'dart:convert';

import 'package:demo/addpage.dart';

import 'package:demo/pop_up.dart';
import 'package:demo/searchpage.dart';
import 'package:demo/studentdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import 'bloc/student_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // DatabaseHelper.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 200, 200, 200),
        appBar: AppBar(
          title: const Text(
            'HOME',
            style: TextStyle(
                fontSize: 33,
                color: Color.fromARGB(255, 98, 98, 98),
                letterSpacing: 2),
          ),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 200, 200, 200),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add_box_outlined,
                size: 25,
              ),
            ),
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchPage());
                },
                icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: BlocBuilder<StudentBloc, StudentState>(
          builder: (context, state) {
            if (state is StudentInitial) {
              context.read<StudentBloc>().add(const FetchStudents());
            }
            if (state is DisplayStudents) {
              return SafeArea(
                  child: state.students.isNotEmpty
                      ? ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemBuilder: ((context, indexx) {
                            final student = state.students[indexx];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              shadowColor: Colors.black38,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              color: const Color.fromARGB(255, 209, 209, 209),
                              child: GestureDetector(
                                onLongPress: () {
                                  
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => StudentDetail(
                                          valueee: indexx,
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: ClipOval(
                                      child: student.image != ''
                                          ? Image.memory(
                                              base64Decode(student.image),
                                              width: 53,
                                              height: 53,
                                              fit: BoxFit.cover,
                                            )
                                          : SvgPicture.asset(
                                              'assets/abstract-user-flat-1.svg',
                                              width: 53,
                                              height: 53,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    title: Text(student.name),
                                    trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertBox(
                                              idd: student.id!,
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                          Icons.delete_outline_outlined),
                                      color: const Color.fromARGB(
                                          255, 113, 48, 44),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 10);
                          },
                          itemCount: state.students.length)
                      : Center(
                          child: Lottie.asset('assets/98312-empty.json'),
                        ));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
