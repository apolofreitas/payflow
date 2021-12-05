import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

import 'home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = HomeController(
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

    return Scaffold(
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
      body: Obx(() => homeController.currentPage),
      bottomNavigationBar: SizedBox(
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                homeController.navigateTo('/red');
              },
              icon: Obx(
                () => Icon(
                  Icons.home,
                  color: homeController.curretRoute == '/red'
                      ? AppColors.primary
                      : AppColors.body,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
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
                homeController.navigateTo('/blue');
              },
              icon: Obx(
                () => Icon(
                  Icons.description_outlined,
                  color: homeController.curretRoute == '/blue'
                      ? AppColors.primary
                      : AppColors.body,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
