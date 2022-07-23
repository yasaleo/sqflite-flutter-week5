
import 'dart:ffi';

class Student {
  final int? id;
  final String name;
  final String image;
  final int    age;
  final int    mobile;
  final String address;

  Student({ this.id, required this.name , required this.image,required this.age,required this.mobile,required this.address});

  factory Student.fromMap(Map<String, dynamic>json) =>  Student(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    age: json['age'],
    mobile: json['mobile'],
    address: json['address']
  );
Map<String,dynamic> toMap(){
  return{
    'id':id,
     "name":name,
     "image":image,
     "age"  :age,
     "mobile":mobile,
     "address":address
  };
}

}