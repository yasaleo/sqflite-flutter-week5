part of 'student_bloc.dart';

@immutable
abstract class StudentEvent extends Equatable {
  const StudentEvent();
}

class AddStudent extends StudentEvent {
  final int? id;
  final String name;
  final String image;
  final int age;
  final int mobile;
  final String address;

  const AddStudent({
    this.id,
    required this.name,
    required this.image,
    required this.age,
    required this.mobile,
    required this.address,
  });
  @override
  List<Object?> get props => [
        id,
        name,
        image,
        age,
        mobile,
        address,
      ];
}

class UpdateStudent extends StudentEvent {
  final Student student;

  const UpdateStudent({required this.student});

  @override
  List<Object?> get props => [student];
}

class FetchStudents extends StudentEvent {
  const FetchStudents();

  @override
  List<Object?> get props => [];
}



class DeleteStudent extends StudentEvent {
  final int id;

  const DeleteStudent({required this.id});

  @override
  List<Object?> get props => [id];
}
