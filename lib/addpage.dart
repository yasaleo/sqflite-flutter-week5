import 'dart:convert';
import 'dart:io';

import 'package:demo/db/db.dart';
import 'package:demo/db/dbmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class AddPage extends StatefulWidget {
  int? idd;
  String? nameeditingcontroller;
  String? addresseditingcontroller;
  String? imagee;
  int? ageeditingcontroller;
  int? mobileeditingcontroller;

  AddPage(
      {Key? key,
      this.idd,
      this.nameeditingcontroller,
      this.addresseditingcontroller,
      this.ageeditingcontroller,
      this.mobileeditingcontroller,
      this.imagee})
      : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState(
        sid: idd,
        namee: nameeditingcontroller,
        addresss: addresseditingcontroller,
        agee: ageeditingcontroller,
        mobilee: mobileeditingcontroller,
        img: imagee,
      );
}

class _AddPageState extends State<AddPage> {
  int? sid;
  String? namee;
  String? addresss;
  int? agee;
  int? mobilee;

  _AddPageState(
      {this.sid, this.namee, this.addresss, this.agee, this.mobilee, this.img});
  TextEditingController nameeditingcontroller = TextEditingController();
  TextEditingController ageeditingcontroller = TextEditingController();
  TextEditingController mobileeditingcontroller = TextEditingController();
  TextEditingController addresseditingcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameeditingcontroller.text = namee ??= '';
    addresseditingcontroller.text = addresss ??= '';
    if (agee == null) {
      ageeditingcontroller.text = '';
    } else {
      ageeditingcontroller.text = agee.toString();
    }

    if (mobilee == null) {
      mobileeditingcontroller.text = '';
    } else {
      mobileeditingcontroller.text = mobilee.toString();
    }
    img??='';
    
  }

  File? image;
  String? img ;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 200, 200),
        elevation: 0,
        actions: [
          TextButton.icon(
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  sid != null ? await update(sid!) : await submit();

                  DatabaseHelper.instance.refresh();
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.done_rounded,
                color: Colors.black38,
              ),
              label: const Text(
                'Done',
                style: TextStyle(color: Colors.black87),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            children: [
              GestureDetector(
                child: img != ''
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10, top: 35),
                        child: Material(
                          type: MaterialType.circle,
                          elevation: 25,
                          color: Colors.transparent,
                          child: ClipOval(
                            child: Image.memory(
                              base64Decode(img!),
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Lottie.asset('assets/lf20_sqha25kl.json',
                            height: 230, frameRate: FrameRate(50)),
                      ),
                onTap: () {
                  choseimage();
                },
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Feild is required';
                    } else {
                      return null;
                    }
                  },
                  controller: nameeditingcontroller,
                  decoration: const InputDecoration(
                      label: Text(
                        'Name',
                        style: TextStyle(color: Colors.black87),
                      ),
                      hintText: 'Enter your full name ',
                      icon: Icon(Icons.keyboard_alt)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  // initialValue: 'yadhu',
                  controller: ageeditingcontroller,
                  validator: (value) {
                    if (value!.isEmpty || value.length > 2) {
                      return 'Type your Correct age';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label:
                          Text('Age', style: TextStyle(color: Colors.black87)),
                      hintText: 'Enter your age ',
                      icon: Icon(Icons.numbers_rounded)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: mobileeditingcontroller,
                  validator: (value) {
                    if (value!.isEmpty || value.length != 10) {
                      return 'enter correct phone number';
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      label: Text('Mobile',
                          style: TextStyle(color: Colors.black87)),
                      hintText: 'Enter your mobile number ',
                      icon: Icon(Icons.phone_outlined)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: addresseditingcontroller,
                  decoration: const InputDecoration(
                      label: Text('Address',
                          style: TextStyle(color: Colors.black87)),
                      hintText: 'Enter house address ',
                      icon: Icon(Icons.home)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future choseimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final tempimage = File(image.path);
    final tempimag = tempimage.readAsBytesSync();
    String imgstring = base64Encode(tempimag);
    setState(() {
      this.image = tempimage;
      img = imgstring;
    });
  }

  update(int id) async {
    int _age = int.parse(ageeditingcontroller.text);
    int _mobile = int.parse(mobileeditingcontroller.text);

    await DatabaseHelper.instance.update(
      Student(
          id: id,
          name: nameeditingcontroller.text,
          image: img!,
          age: _age,
          mobile: _mobile,
          address: addresseditingcontroller.text),
    );
    setState(() {
      nameeditingcontroller.clear();
      ageeditingcontroller.clear();
      mobileeditingcontroller.clear();
      addresseditingcontroller.clear();
      sid = null;
    });
  }

  submit() async {
    int _age = int.parse(ageeditingcontroller.text);
    int _mobile = int.parse(mobileeditingcontroller.text);
    await DatabaseHelper.instance.add(Student(
        name: nameeditingcontroller.text,
        image: img!,
        age: _age,
        mobile: _mobile,
        address: addresseditingcontroller.text));

    setState(() {
      nameeditingcontroller.clear();
      ageeditingcontroller.clear();
      mobileeditingcontroller.clear();
      addresseditingcontroller.clear();
    });
  }
}
