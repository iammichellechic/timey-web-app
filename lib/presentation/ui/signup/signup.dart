import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/base_layout.dart';
import 'package:timey_web/presentation/utils/clip_path_utils.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';
import 'package:timey_web/presentation/widgets/textfield_container.dart';
import 'package:timey_web/presentation/widgets/textformfield_container.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/values_manager.dart';
import '../login/login.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: CustomClipPath(),
        child: Container(child: buildSignupForm(context)));
  }

  Widget buildSignupForm(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
          builder: (context, sizingInformation) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            AppPadding.p12, 0, AppPadding.p12, 0),
                        color: ColorManager.blue,
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SIGNUP',
                                  style: makeYourOwnBoldStyle(
                                      fontSize: FontSize.s24,
                                      color: ColorManager.primaryWhite),
                                ),
                                SizedBox(height: AppSize.s30),
                                TextFieldContainer(
                                    borderColor: ColorManager.primaryWhite,
                                    child: TextFormFieldContainer(
                                      text: 'FIRSTNAME',
                                      style: makeYourOwnBoldStyle(
                                          fontSize: FontSize.s16,
                                          color: ColorManager.blue),
                                    )),
                                SizedBox(height: AppSize.s10),
                                TextFieldContainer(
                                    borderColor: ColorManager.primaryWhite,
                                    child: TextFormFieldContainer(
                                      text: 'LASTNAME',
                                      style: makeYourOwnBoldStyle(
                                          fontSize: FontSize.s16,
                                          color: ColorManager.blue),
                                    )),
                                SizedBox(height: AppSize.s10),
                                TextFieldContainer(
                                    borderColor: ColorManager.primaryWhite,
                                    child: TextFormFieldContainer(
                                      text: 'USERNAME',
                                      style: makeYourOwnBoldStyle(
                                          fontSize: FontSize.s16,
                                          color: ColorManager.blue),
                                    )),
                                SizedBox(height: AppSize.s10),
                                TextFieldContainer(
                                    borderColor: ColorManager.primaryWhite,
                                    child: TextFormFieldContainer(
                                      text: 'PASSWORD',
                                      style: makeYourOwnBoldStyle(
                                          fontSize: FontSize.s16,
                                          color: ColorManager.blue),
                                    )),
                                SizedBox(height: AppSize.s10),
                                SizedBox(
                                  width: double.infinity,
                                  child: ButtonWidget(
                                    text: 'SIGNUP',
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                    onClicked: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BaseLayout()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    color: ColorManager.orange,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s30),
                                    ),
                                  ),
                                ),
                                SizedBox(height: AppSize.s10),
                                Center(
                                  child: RichText(
                                      text: TextSpan(
                                          text: 'Already have an account? ',
                                          children: [
                                        TextSpan(
                                          text: 'Click here',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen()));
                                            },
                                        )
                                      ])),
                                ),
                              ]),
                        ),
                      )),
                  if (sizingInformation.isDesktop)
                    Expanded(flex: 2, child: buildBlackScreen(context))
                ],
              )),
    );
  }

  Widget buildBlackScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blue,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 500,
                child: Image.asset(
                  ImageAssets.loginPicture,
                ),
              ),
            ),
            Center(
              child: Text(
                "START TRACKING TIME WITH TIMEY",
                style: makeYourOwnBoldStyle(
                    color: ColorManager.primaryWhite,
                    fontSize: FontSize.s36,
                    height: 1.5,
                    letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
