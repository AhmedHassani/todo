import 'package:flutter/material.dart';

class CustomTaskTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String startDate;
  final String endDate;
  final bool isDone;
  final Function()? onDelete;
  final Function()? onTab;
  final Color doneColor;
  final Color undoneColor;

  const CustomTaskTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.startDate,
    required this.endDate,
    this.isDone = false,
    this.onDelete,
    this.onTab,
    this.doneColor = Colors.green,
    this.undoneColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        onTap: onTab,
        title: Text(
          title,
          textDirection:TextDirection.rtl,
          textAlign: TextAlign.right,
          style: isDoneStyle(),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subtitle,
              textDirection:TextDirection.rtl,
              textAlign: TextAlign.right,
              style:isDoneStyle() ,
            ),
            const SizedBox(height: 4),
            Text(
             'تاريخ البدء : ${startDate}',
              textDirection:TextDirection.rtl,
              textAlign: TextAlign.right,
              style: isDoneStyle(),
            ),
            Text(
              'تاريخ الانتهاء : ${endDate}',
              textDirection:TextDirection.rtl,
              textAlign: TextAlign.right,
              style: isDoneStyle(),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  isDoneStyle(){
     return TextStyle(
       overflow: TextOverflow.ellipsis,
       color: isDone ? Colors.black38 : Colors.black87,
       decoration: isDone ? TextDecoration.lineThrough : null,
     );
  }
}
