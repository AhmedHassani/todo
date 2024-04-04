import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:todo/core/controllers/db_controller.dart';

import 'core/values/colors.dart';

class InfoPage extends GetView<DBController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(()=>Scaffold(
          appBar: AppBar(
            backgroundColor: controller.appBarColor.value,
            title: Text('Info'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  'مرحبًا بك في تطبيق المهام الخاص بي!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBulletPoint('أضف المهام إلى قائمة المهام الخاصة بك عن طريق الضغط على زر "+"'),
                      _buildBulletPoint('حدد المهام كمكتملة عن طريق الضغط عليها'),
                      _buildBulletPoint('اسحب المهمة يسارًا لحذفها'),
                      _buildBulletPoint('قم بتحرير المهام عن طريق الضغط عليها'),
                      _buildBulletPoint('قم بتحرير المهام عن طريق الضغط عليها'),
                      _buildBulletPoint('قم بتحرير المهام عن طريق الضغط عليها'),
                      _buildBulletPoint('قم بتحرير المهام عن طريق الضغط عليها'),
                      _buildBulletPoint('قم بتحرير المهام عن طريق الضغط عليها'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ))
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle,
            size: 20,
            color: Colors.green,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
