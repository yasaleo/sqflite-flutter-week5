import 'dart:convert';

import 'package:demo/addpage.dart';
import 'package:demo/db/db.dart';
import 'package:demo/db/dbmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudentDetail extends StatelessWidget {
  final valueee;
  late Student ids;

  StudentDetail({this.valueee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        elevation: 0,
        title: const Text(
          'Detail',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 98, 98, 98),
              letterSpacing: 4),
        ),
        backgroundColor: const Color.fromARGB(255, 200, 200, 200),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPage(
                        idd: ids.id,
                        nameeditingcontroller: ids.name,
                        addresseditingcontroller: ids.address,
                        ageeditingcontroller: ids.age,
                        mobileeditingcontroller: ids.mobile,
                        imagee: ids.image,
                        
                        ),
                    ));
              },
              icon: const Icon(Icons.mode_edit_outlined))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: DatabaseHelper.instance.helperrr,
          builder: (BuildContext context, List<Student> detaillist, Widget? _) {
            final newdetail = detaillist[valueee];
            ids = newdetail;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 35),
                    child: Material(
                      type: MaterialType.circle,
                      elevation: 20,
                      color: Colors.transparent,
                      child: ClipOval(
                          child: newdetail.image != ''
                              ? Image.memory(
                                  base64Decode(newdetail.image),
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  'assets/abstract-user-flat-1.svg',
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.cover,
                                )),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(' ${newdetail.name}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  cardwidget(
                    newdetail.age,
                    const Text(
                      'Age:',
                      style: TextStyle(
                          fontSize: 27,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  cardwidget(
                    newdetail.mobile,
                    const Text(
                      'Mobile:',
                      style: TextStyle(
                          fontSize: 27,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  cardwidget(
                    newdetail.address,
                    const Text(
                      'Address:',
                      style: TextStyle(
                          fontSize: 27,
                          color: Color.fromARGB(255, 104, 104, 104),
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            );
          }),

      // body: Center(child: Text(valueee.name)),
    );
  }

  Widget cardwidget(var text, Widget icon) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: const Color.fromARGB(255, 199, 199, 199),
      child: ListTile(
        leading: icon,
        title: Text(' $text', style: const TextStyle(fontSize: 30)),
      ),
    );
  }
}
