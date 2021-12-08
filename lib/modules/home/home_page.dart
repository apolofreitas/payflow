import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:payflow/modules/extract/extract_page.dart';
import 'package:payflow/modules/my_boletos/my_boletos_page.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController(
    initialRoute: '/my_boletos',
    routes: {
      '/my_boletos': const MyBoletosPage(),
      '/extract': const ExtractPage(),
    },
  );

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<User?>()!;

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
                            text: currentUser.displayName,
                            style: AppTextStyles.titleBoldBackground,
                          )
                        ]),
                  ),
                  subtitle: Text(
                    "Mantenha suas contas em dia",
                    style: AppTextStyles.captionShape,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (currentUser.photoURL != null)
                        Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(currentUser.photoURL!),
                            ),
                          ),
                        ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Sair da Conta'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: const <Widget>[
                                        Text('Tem certeza que deseja sair?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Cancelar',
                                        style: AppTextStyles.buttonGray,
                                      ),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Sair',
                                        style: AppTextStyles.buttonPrimary,
                                      ),
                                      onPressed: () async {
                                        await FirebaseAuth.instance.signOut();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: AppColors.background,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: Obx(() {
            return controller.currentPage;
          }),
          bottomNavigationBar: SizedBox(
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    controller.navigateTo('/my_boletos');
                  },
                  icon: Obx(
                    () => Icon(
                      Icons.home,
                      color: controller.curretRoute == '/my_boletos'
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
                    controller.navigateTo('/extract');
                  },
                  icon: Obx(
                    () => Icon(
                      Icons.description_outlined,
                      color: controller.curretRoute == '/extract'
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
