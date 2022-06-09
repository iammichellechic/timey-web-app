import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:timey_web/presentation/widgets/button_widget.dart';
import 'package:timey_web/presentation/widgets/textfield_container.dart';
import 'package:timey_web/presentation/widgets/textformfield_container.dart';
import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(child: buildSignupForm(context));
  }

  Widget buildSignupForm(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          AppPadding.p12, 0, AppPadding.p12, 0),
                      color: ColorManager.primaryWhite,
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'SIGNUP',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              SizedBox(height: AppSize.s30),
                              TextFieldContainer(
                                child: TextFormFieldContainer(
                                  text: 'FIRSTNAME',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              SizedBox(height: AppSize.s10),
                              TextFieldContainer(
                                child: TextFormFieldContainer(
                                  text: 'LASTNAME',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              SizedBox(height: AppSize.s10),
                              TextFieldContainer(
                                child: TextFormFieldContainer(
                                  text: 'USERNAME',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              SizedBox(height: AppSize.s10),
                              TextFieldContainer(
                                child: TextFormFieldContainer(
                                  text: 'PASSWORD',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                              SizedBox(height: AppSize.s10),
                              SizedBox(
                                width: double.infinity,
                                child: ButtonWidget(
                                  text: 'SIGNUP',
                                  style: Theme.of(context).textTheme.headline6,
                                  onClicked: () {},
                                  color: ColorManager.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s30),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )),
                if (sizingInformation.isDesktop)
                  Expanded(flex: 2, child: buildBlackScreen(context))
              ],
            ));
  }

  Widget buildBlackScreen(BuildContext context) {
    return Container(color: ColorManager.black);
  }
}
