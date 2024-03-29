import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/todo_view.dart';

import 'core/values/colors.dart';
import 'model.dart';

class TodoView extends StatefulWidget {
  String s;

  TodoView(this.s, {Key? key}) : super(key: key);

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late Box<Todo> _todoBox;
  var todos  = [];

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    _todoBox = await Hive.openBox<Todo>('all');
    todos = _todoBox.values.toList();
    if(widget.s != 'all') {
      todos = todos.where((todo) => widget.s == todo.type).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              widget.s == "all" ?
              Container() : IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                   Get.to(() => AddAndEditTask(type: widget.s, action: "add",))!.then((value){
                     setState(() {
                       _openBox();
                     });
                   });
                },
              )
            ],
            title: Text("المهام"),
            backgroundColor: yellow,
          ),
          body:_buildTodoList(),
        ));
  }

  Widget _buildTodoList() {
    return ListView.separated(
      itemCount: todos.length,
      itemBuilder: (context, index) {
         return ListTile(
            onTap: () {
              Get.to(() =>
                  AddAndEditTask(
                    type: widget.s, action: "edit", todo: todos[index], index: index,)
              )!.then((value) {
                setState(() {
                  _openBox();
                });
              });
            },
            title: Text(
              todos[index].title,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${todos[index].note}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,

                ),
                Text(
                  "${todos[index].date} - ${todos[index].time}",
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                )
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  _todoBox.deleteAt(index);
                   _openBox();
                });
              },
            ),
          );
      }, separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },
    );
  }


}
