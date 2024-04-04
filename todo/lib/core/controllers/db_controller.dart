import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../model.dart';
import 'package:flutter/material.dart';

class DBController extends GetxController {
  RxString type = ''.obs;
  late Box<Todo> _todoBox;
  Rx<Color> appBarColor = Colors.blue.obs;


  List<Todo> todoList = [];
  RxInt all = 0.obs;
  RxMap<String, int> typeCount = {
    "privacy": 0,
    "progress": 0,
    "graduates": 0,
    "cart": 0,
    "heartbeat": 0,
  }.obs;

  @override
  Future<void> onInit() async {
    _todoBox = await Hive.openBox<Todo>('all');
    _count();
    super.onInit();
  }

  Future<void> _count() async {
    all.value = _todoBox.length;
    typeCount.value = Map.fromIterable(
      _todoBox.values,
      key: (todo) => todo.type,
      value: (_) => _todoBox.values.where((todo) => todo.type == _.type).length,
    );
    update();
  }

  Future<void> editTodo(int index, Todo todo) async {
    _todoBox.putAt(index, todo);
    _updateData();
  }

  Future<void> addTodo(Todo todo) async {
    _todoBox.add(todo);
    _updateData();
  }

  Future<void> getByType() async {
    todoList = _todoBox.values.where((todo) => type.value == 'all' || todo.type == type.value).toList();
    update();
  }

  Future<void> deleteById(String uuid) async {
    int index = _todoBox.values.toList().indexWhere((todo) => todo.uuid == uuid);
    if (index != -1) {
      _todoBox.deleteAt(index);
      _updateData();
    }
  }

  Future<void> _updateData() async {
    await _count();
    await getByType();
  }

  @override
  void onClose() {
    _todoBox.close();
    super.onClose();
  }

  void updateAppBarColor(Color color) {
    if (color is MaterialColor) {
      appBarColor.value = color;
    } else {
      // Convert the Color to MaterialColor
      final materialColor = MaterialColor(color.value, {
        50: color.withOpacity(0.1),
        100: color.withOpacity(0.2),
        200: color.withOpacity(0.3),
        300: color.withOpacity(0.4),
        400: color.withOpacity(0.5),
        500: color.withOpacity(0.6),
        600: color.withOpacity(0.7),
        700: color.withOpacity(0.8),
        800: color.withOpacity(0.9),
        900: color.withOpacity(1.0),
      });
      appBarColor.value = materialColor;
    }
  }
}
