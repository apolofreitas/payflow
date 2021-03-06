import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/social_login/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.4,
                color: AppColors.primary,
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Stack(
                  children: [
                    Stack(alignment: Alignment.bottomCenter, children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: AssetImage(AppImages.person),
                          ),
                        ),
                        height: size.height * 0.475,
                      ),
                      Container(
                        height: 90.0,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          gradient: LinearGradient(
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                            colors: [
                              AppColors.background.withOpacity(0.0),
                              AppColors.background.withOpacity(1.0),
                            ],
                            stops: const [0.0, 1.0],
                          ),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
              Positioned(
                  height: size.height * 0.4,
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(AppImages.logoMini),
                      Padding(
                        padding: const EdgeInsets.only(left: 70, right: 70),
                        child: Text(
                          "Organize seus boletos em um lugar s??",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.titleHome,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: SocialLoginButton(
                          onTap: controller.signInWithGoogle,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
