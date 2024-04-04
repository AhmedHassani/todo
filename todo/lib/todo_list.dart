import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/model.dart';
import 'package:todo/todo_view.dart';
import 'core/controllers/db_controller.dart';
import 'core/utils/custom_list_tile.dart';
import 'core/values/colors.dart';

class TodoView extends GetView<DBController> {
  TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(()=>Scaffold(
          appBar: AppBar(

            actions: [
              controller.type.value == "all"
                  ? Container()
                  : IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.to(() => AddAndEditTask(
                    type: controller.type.value,
                    action: "add",
                  ));
                },
              )
            ],
            title: const Text("المهام"),
            backgroundColor: controller.appBarColor.value,
          ),
          body: GetBuilder(
            builder: (DBController controller) {
              if (controller.todoList.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text("لا يوجد مهام"),
                    )
                  ],
                );
              } else {
                return _buildTodoList();
              }
            },
          ),
        )));
  }

  Widget _buildTodoList() {
    List<Todo> todos = controller.todoList;
    return ListView.separated(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return CustomTaskTile(
          title:todos[index].title,
          subtitle:todos[index].note,
          startDate: todos[index].date,
          isDone: todos[index].isDone,
          endDate: todos[index].time,
          onDelete: (){
            controller.deleteById(todos[index].uuid);
          },
          onTab: (){
            Get.to(() => AddAndEditTask(
              type: controller.type.value,
              action: "edit",
              todo: todos[index],
              index: index,
            ));
          },
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}

/*
  final String title;
  final String subtitle;
  final DateTime startDate;
  final DateTime endDate;
  final bool isDone;
  final Function(bool?)? onDoneChanged;
  final Function()? onDelete;
 */


/*

ListTile(
          onTap: () {
            Get.to(() => AddAndEditTask(
                  type: controller.type.value,
                  action: "edit",
                  todo: todos[index],
                  index: index,
                ));
          },
          title: Text(
            todos[index].title,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: todos[index].isDone
            ? const TextStyle(
            decoration: TextDecoration.lineThrough, // Cross out text
          ) : const TextStyle(),
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
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              print("delete item at : ${todos[index].toString()}");
              controller.deleteById(todos[index].uuid);
            },
          ),
        )
 */