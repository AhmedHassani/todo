import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/info.dart';
import 'package:todo/todo_list.dart';
import 'core/controllers/db_controller.dart';
import 'core/utils/hlaf-circle.dart';
import 'core/values/colors.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class HomePage extends GetView<DBController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Obx(() => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(
                      Icons.color_lens,
                      size: 27,
                      color: Colors.white,
                  ),
                  onPressed: () {
                    _openColorPicker(context);
                  },
                ),
              ],
              leading: IconButton(
                icon: const Icon(
                  Icons.info,
                  size: 27,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.to(() => InfoPage());
                },
              ),
              backgroundColor: controller.appBarColor.value,
            ),
            body: Container(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: HalfTabletClipper(),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 130, // Adjust height as needed
                        color: controller.appBarColor.value, // Change color and opacity as needed
                      ),
                    ),
                  ),
                  ListView(
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        title: const Text("مرحبا مجددا"),
                        subtitle: Text(
                            "لديك ${controller.all.value ?? 0} مهام غير مكتملة"),
                        trailing: Image.asset("images/woman.png"),
                      ),
                      _buildGestureDetector("all", "كل المهام", "all.png",
                          controller.all.value ?? 0),
                      _buildGestureDetector("privacy", "شخصي", "privacy.png",
                          controller.typeCount["privacy"] ?? 0),
                      _buildGestureDetector("progress", "عمل", "progress.png",
                          controller.typeCount["progress"] ?? 0),
                      _buildGestureDetector("graduates", "دراسة", "graduates.png",
                          controller.typeCount["graduates"] ?? 0),
                      _buildGestureDetector("cart", "تسوق", "cart.png",
                          controller.typeCount["cart"] ?? 0),
                      _buildGestureDetector("heartbeat", "صحة", "heartbeat.png",
                          controller.typeCount["heartbeat"] ?? 0),
                    ],
                  ),

                ],
              ),
            )
        ,
          )),
    );
  }

  Widget _buildGestureDetector(
      String type, String title, String leadingImage, int count) {
    return GestureDetector(
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
          title: Text(title),
          subtitle: Text("عدد المهام هو: $count"),
          leading: Image.asset("images/$leadingImage"),
        ),
      ),
      onTap: () async {
        controller.type.value = type;
        controller.getByType();
        Get.to(() => TodoView());
      },
    );
  }

  void _openColorPicker(BuildContext context) {
    Color selectedColor = controller.appBarColor.value; // Get current color
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('حدد لون الشريط العلوي'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (Color color) {
                selectedColor = color;
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                controller.updateAppBarColor(
                    selectedColor); // Update app bar color using controller
                Get.back();
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}

/*
ListView(
                  children: [
                    SizedBox(height: 10),
                    ListTile(
                      title: const Text("مرحبا مجددا"),
                      subtitle: Text(
                          "لديك ${controller.all.value ?? 0} مهام غير مكتملة"),
                      trailing: Image.asset("images/woman.png"),
                    ),
                    _buildGestureDetector("all", "كل المهام", "all.png",
                        controller.all.value ?? 0),
                    _buildGestureDetector("privacy", "شخصي", "privacy.png",
                        controller.typeCount["privacy"] ?? 0),
                    _buildGestureDetector("progress", "عمل", "progress.png",
                        controller.typeCount["progress"] ?? 0),
                    _buildGestureDetector("graduates", "دراسة", "graduates.png",
                        controller.typeCount["graduates"] ?? 0),
                    _buildGestureDetector("cart", "تسوق", "cart.png",
                        controller.typeCount["cart"] ?? 0),
                    _buildGestureDetector("heartbeat", "صحة", "heartbeat.png",
                        controller.typeCount["heartbeat"] ?? 0),
                  ],
                )
 */
