import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/todo_list.dart';
import 'core/values/colors.dart';
import 'model.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  late Box<Todo> _todoBox;
  int all  = 0;
  List<Todo> todos  = [];
  Map<String, int> typeCount = {};


  @override
  void initState() {
    typeCount["privacy"] =0;
    typeCount["progress"] =0;
    typeCount["graduates"] =0;
    typeCount["cart"] =0;
    typeCount["heartbeat"] =0;
    _openBox();
    super.initState();
  }

  Future<void> _openBox() async {
    _todoBox = await Hive.openBox<Todo>('all');
    todos = _todoBox.values.toList();
    for(Todo todo in todos){
      typeCount[todo.type] = (typeCount[todo.type] ?? 0) + 1;
    }
    all = _todoBox.values.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.notifications_active_outlined,
              size: 35,
              color: Color.fromRGBO(189, 202, 216,1),
            ),
            onPressed: () {
            },
          ),
          backgroundColor: yellow,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/back1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: const Text("مرحبا مجددا"),
                subtitle: Text("لديك"+" ${all} "+"مهام غير مكتمله"),
                trailing: Image.asset("images/woman.png"),
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("كل المهام"),
                    subtitle: Text(" عدد المهام هو"+" : "+"${all}"),
                    leading: Image.asset("images/all.png"),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
                onTap: () {
                  Get.to(() => TodoView("all"));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("شخصي"),
                    subtitle: Text(" عدد المهام هو"+" : "+"${typeCount["privacy"]}"),
                    leading: Image.asset("images/privacy.png"),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
                onTap: () {
                  Get.to(() => TodoView("privacy"));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("عمل"),
                    subtitle: Text(" عدد المهام هو"+" : "+"${typeCount["progress"]}"),
                    leading: Image.asset("images/progress.png"),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
                onTap: () {
                  Get.to(() => TodoView("progress"));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("دراسه"),
                    subtitle: Text(" عدد المهام هو"+" : "+"${typeCount["graduates"]}"),
                    leading: Image.asset("images/graduates.png"),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
                onTap: () {
                  Get.to(() => TodoView("graduates"));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("تسوق"),
                    subtitle: Text(" عدد المهام هو"+" : "+"${typeCount["cart"]}"),
                    leading: Image.asset("images/cart.png"),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
                onTap: () {
                  Get.to(() => TodoView("cart"));
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text("صحه"),
                    subtitle: Text(" عدد المهام هو"+" : "+"${typeCount["heartbeat"]}"),
                    leading: Image.asset("images/heartbeat.png"),
                    trailing: Icon(Icons.more_vert),
                  ),
                ),
                onTap: () {
                  Get.to(() => TodoView("heartbeat"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
