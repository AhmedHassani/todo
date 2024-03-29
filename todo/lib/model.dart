import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String note;

  @HiveField(2)
  final String date;

  @HiveField(3)
  final String time;

  @HiveField(4)
  final bool isDone;

  @HiveField(5)
  final String type;

  const Todo(this.title, this.note, this.date, this.time, this.isDone, this.type);
}
