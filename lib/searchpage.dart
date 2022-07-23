import 'package:demo/db/db.dart';
import 'package:demo/db/dbmodel.dart';
import 'package:demo/home.dart';
import 'package:demo/studentdetail.dart';
import 'package:flutter/material.dart';

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
    return IconButton(onPressed: () {
      close(context, query);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
   return ValueListenableBuilder(
    valueListenable: DatabaseHelper.instance.helperrr,
     builder: (BuildContext context,List<Student>newlist,Widget?_){
      return 
         ListView.separated(
          itemBuilder:((context, index) {
            final value = newlist[index];
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
                              DatabaseHelper.instance.remove(value.id!);
                              DatabaseHelper.instance.refresh();
                              alerted(context);
                              
                            },
                            icon: const Icon(Icons.delete_outline_outlined),
                            color: const Color.fromARGB(255, 113, 48, 44)),
                      ),
                    ),
                  );
              
            }else{
              return const SizedBox(height: 1,);
            }
          }) ,
           separatorBuilder:(context,index){
            return const SizedBox();
           } ,
            itemCount:newlist.length );
      
     }
     );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
    valueListenable: DatabaseHelper.instance.helperrr,
     builder: (BuildContext context,List<Student>newlist,Widget?_){
      return ListView.separated(
        itemBuilder:((context, index) {
          final value = newlist[index];
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
                              DatabaseHelper.instance.remove(value.id!);
                              DatabaseHelper.instance.refresh();
                              alerted(context);
                              
                            },
                            icon: const Icon(Icons.delete_outline_outlined),
                            color: const Color.fromARGB(255, 113, 48, 44)),
                      ),
                    ),
                  );
            
          }else{
            return const SizedBox(height: 1,);
          }
        }) ,
         separatorBuilder:(context,index){
          return const SizedBox();
         } ,
          itemCount:newlist.length );
     }
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
