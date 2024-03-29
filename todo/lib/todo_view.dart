import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hive/hive.dart';
import 'package:todo/core/utils/notification_service.dart';
import 'core/values/colors.dart';
import 'model.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;

class AddAndEditTask extends StatefulWidget {
  String type;
  String action;
  Todo? todo;
  int index;

  AddAndEditTask(
      {required this.type,
      required this.action,
      this.todo,
      this.index = 0,
      Key? key})
      : super(key: key);

  @override
  State<AddAndEditTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddAndEditTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  late String startDate;
  late String endDate;
  NotificationService serviceNotification = NotificationService();

  @override
  void initState() {
    if (widget.action == 'edit') {
      _titleController.text = widget.todo!.title;
      _noteController.text = widget.todo!.note;
    }
    String date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}"
        " ${DateTime.now().hour}:${DateTime.now().minute}";
    startDate = date;
    endDate = date;
  }

  void _selectStartDate(String data) {
    DateTime dateTime = DateTime.parse(data);
    String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}"
        " ${dateTime.hour}:${dateTime.minute}";
    startDate = date;
    setState(() {
    });
  }


  void _selectEndDate(String data) {
    DateTime dateTime = DateTime.parse(data);
    String date = "${dateTime.year}-${dateTime.month}-${dateTime.day}"
        " ${dateTime.hour}:${dateTime.minute}";
    endDate = date;
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(
                Icons.done,
                color: Colors.black,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var box = await Hive.openBox<Todo>('all');
                  var todo = Todo(
                    _titleController.text,
                    _noteController.text,
                    startDate,
                    endDate,
                    false,
                    widget.type,
                  );
                  if (widget.action == 'edit') {
                    box.putAt(widget.index, todo);
                    print(startDate);
                    serviceNotification.showNotification(startDate,"${todo.title}"+"تذكير انجاز مهمه","ابدأ الآن وقم بالخطوات الأولى نحو تحقيق أهدافك");
                    serviceNotification.showNotification(endDate,"${todo.title}"+"تذكير انجاز مهمه","انجز المهمه قبل انتهاء الوقت المحدد");
                  }
                  if (widget.action == 'add') {
                    box.add(todo);
                    serviceNotification.showNotification(startDate,"${todo.title}"+"تذكير انجاز مهمه","ابدأ الآن وقم بالخطوات الأولى نحو تحقيق أهدافك");
                    serviceNotification.showNotification(endDate,"${todo.title}"+"تذكير انجاز مهمه","انجز المهمه قبل انتهاء الوقت المحدد");
                  }
                  _titleController.clear();
                  _noteController.clear();
                }
              },
            )
          ],
          title: Text("تعديل المهام"),
          backgroundColor: yellow,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 3,
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white24,
                          width: 0.3,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    maxLines: 12,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white24,
                          width: 0.3,
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                    ),
                    controller: _noteController,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${startDate}'),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          picker.DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2024, 1, 1),
                              maxTime: DateTime(2090, 1, 1), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                _selectStartDate(date.toString());
                              }, currentTime: DateTime.now(), locale: LocaleType.ar);
                        },
                        child: Text('Start Date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${endDate}'),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          picker.DatePicker.showDateTimePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(2024, 1, 1),
                              maxTime: DateTime(2090, 1, 1), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                _selectEndDate(date.toString());
                              }, currentTime: DateTime.now(), locale: LocaleType.ar);
                        },
                        child: Text('End Time'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
