import 'package:flutter/material.dart';
import 'package:flutter_application_login_with_bloc/src/blocs/auth/auth_bloc.dart';
import 'package:flutter_application_login_with_bloc/src/view/components/image_builder.dart';
import 'package:flutter_application_login_with_bloc/src/view/components/loader.dart';
import 'package:flutter_application_login_with_bloc/src/view/declarations/constants/constants.dart';
import 'package:flutter_application_login_with_bloc/src/view/declarations/Images/images.dart';
import 'package:flutter_application_login_with_bloc/src/view/pages/widgets/login_btn.dart';
import 'package:flutter_application_login_with_bloc/src/view/pages/widgets/text_data_widget.dart';
import 'package:flutter_application_login_with_bloc/src/view/pages/widgets/text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/spacers.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FocusNode usernameFocus;
  late FocusNode passwordFocus;
  late FocusNode loginBtnFocus;
  late TextEditingController userName;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    usernameFocus = FocusNode();
    passwordFocus = FocusNode();
    loginBtnFocus = FocusNode();
    userName = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    usernameFocus.dispose();
    passwordFocus.dispose();
    loginBtnFocus.dispose();
    userName.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            buildErrorLayoutEmptyCredentials();
          } else if (state is AuthIncorrectCredentials) {
            buildErrorLayoutIncorrectCredentials();
          } else if (state is AuthLoaded) {
            clearTextData();
            Navigator.of(context).pushNamed('/home', arguments: state.username);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return LoadingWidget(child: buildInitialInput());
          } else {
            return buildInitialInput();
          }
        },
      ),
    );
  }

  Widget buildInitialInput() => SingleChildScrollView(
        child: Column(
          children: [
            ImageBuilder(imagePath: loginImages[1]),
            const TextData(message: ""),
            HeightSpacer(myHeight: kSpacing),
            InputField(
              focusNode: usernameFocus,
              textController: userName,
              label: "Usuário",
              icons: const Icon(Icons.person, color: Colors.blue),
            ),
            HeightSpacer(myHeight: kSpacing),
            InputField(
              focusNode: passwordFocus,
              textController: password,
              label: "Senha",
              icons: const Icon(Icons.lock, color: Colors.blue),
            ),
            HeightSpacer(myHeight: kSpacing),
            LoginBtn(
              focusNode: loginBtnFocus,
              userName: userName,
              password: password,
            ),
          ],
        ),
      );

  ScaffoldFeatureController buildErrorLayoutEmptyCredentials() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, informe o usuário/senha!'),
        ),
      );

  ScaffoldFeatureController buildErrorLayoutIncorrectCredentials() =>
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credenciais inválidas, tente novamente!'),
        ),
      );

  clearTextData() {
    userName.clear();
    password.clear();
  }
}
