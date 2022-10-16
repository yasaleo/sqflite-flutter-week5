import 'package:demo/db/db.dart';
import 'package:flutter/material.dart';

class AlertBox extends StatefulWidget {
  int idd;
  AlertBox({required this.idd});

  @override
  State<AlertBox> createState() => _AlertBoxState(idd: idd);
}

class _AlertBoxState extends State<AlertBox>
    with SingleTickerProviderStateMixin {
  int idd;
  _AlertBoxState({required this.idd});
  late AnimationController anicontroller;

// TODO: bloc cheyy

  @override
  void initState() {
    super.initState();
    anicontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    anicontroller.forward().then((value) async {
      await Future.delayed(const Duration(seconds: 1));
      anicontroller.reverse().then((value) async {
        await Future.delayed(const Duration(seconds: 1));
        anicontroller.forward();
      });
    });
  }

  @override
  void dispose() {
    anicontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 200, 200, 200),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: const Color.fromARGB(255, 200, 200, 200),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: anicontroller,
                    color: Colors.red,
                    size: 120,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Text(
                          'Are you sure ?',
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 90, 17, 12)),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 157, 13, 0),
                                  elevation: 16),
                              onPressed: () {
                                DatabaseHelper.instance.remove(idd);
                                DatabaseHelper.instance.refresh();
                                alerted(context);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 175, 168),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 152,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 157, 13, 0),
                                  elevation: 16),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 175, 168),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
