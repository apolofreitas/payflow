import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = HomeController(
      initialRoute: '/red',
      routes: {
        '/red': Container(
          color: Colors.red,
        ),
        '/blue': Container(
          color: Colors.blue,
        )
      },
    );

    return WillPopScope(
      onWillPop: () async {
        if (controller.curretRoute == controller.initialRoute) {
          return true;
        }
        controller.navigateTo(controller.initialRoute);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(152),
            child: Container(
              height: 152,
              color: AppColors.primary,
              child: Center(
                child: ListTile(
                  title: Text.rich(
                    TextSpan(
                        text: "Olá, ",
                        style: AppTextStyles.titleRegular,
                        children: [
                          TextSpan(
                            text: "Apolo",
                            style: AppTextStyles.titleBoldBackground,
                          )
                        ]),
                  ),
                  subtitle: Text(
                    "Mantenha suas contas em dia",
                    style: AppTextStyles.captionShape,
                  ),
                  trailing: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Obx(() => controller.currentPage),
          bottomNavigationBar: SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    controller.navigateTo('/red');
                  },
                  icon: Obx(
                    () => Icon(
                      Icons.home,
                      color: controller.curretRoute == '/red'
                          ? AppColors.primary
                          : AppColors.body,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/barcode_scanner");
                  },
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.add_box_outlined,
                      color: AppColors.background,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.navigateTo('/blue');
                  },
                  icon: Obx(
                    () => Icon(
                      Icons.description_outlined,
                      color: controller.curretRoute == '/blue'
                          ? AppColors.primary
                          : AppColors.body,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
