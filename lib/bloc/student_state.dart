part of 'student_bloc.dart';

@immutable
abstract class StudentState extends Equatable {
  const StudentState();
}

class StudentInitial extends StudentState {
  @override
  List<Object> get props => [];
}

class DisplayStudents extends StudentState {
  final List<Student> students;
  const DisplayStudents({required this.students});
  @override
  List<Object> get props => [students];
}


