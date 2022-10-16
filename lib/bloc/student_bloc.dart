import 'package:bloc/bloc.dart';
import 'package:demo/db/db.dart';
import 'package:demo/db/dbmodel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    List<Student> students = [];
    on<AddStudent>((event, emit) async {
      await DatabaseHelper.instance.add(Student(
        name: event.name,
        image: event.image,
        age: event.age,
        mobile: event.mobile,
        address: event.address,
      ));
    });
    on<UpdateStudent>((event, emit) async {
      await DatabaseHelper.instance.update(event.student);
    });

    on<FetchStudents>((event, emit) async {
      students = await DatabaseHelper.instance.getStudent();
      emit(DisplayStudents(students: students));
    });

    on<DeleteStudent>((event, emit) async {
      await DatabaseHelper.instance.remove(event.id);
      add(const FetchStudents());
    });

   
  }
}
