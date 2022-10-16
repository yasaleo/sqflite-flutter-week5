class Student {
  final int? id;
  final String name;
  final String image;
  final int age;
  final int mobile;
  final String address;

  Student(
      {this.id,
      required this.name,
      required this.image,
      required this.age,
      required this.mobile,
      required this.address});

  factory Student.fromMap(Map<String, dynamic> json) => Student(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        age: json['age'],
        mobile: json['mobile'],
        address: json['address'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "name": name,
      "image": image,
      "age": age,
      "mobile": mobile,
      "address": address
    };
  }
}

// class StudentFeilds {
//   static const List<String> values = [
//     id,
//     name,
//     image,
//     age,
//     mobile,
//     address,
//   ];

//   static const String id = 'id';
//   static const String name = 'name';
//   static const String image = 'image';
//   static const String age = 'age';
//   static const String mobile = 'mobile';
//   static const String address = 'address';
// }
