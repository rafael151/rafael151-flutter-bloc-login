import 'package:flutter/material.dart';
import 'package:flutter_application_login_with_bloc/src/blocs/home/home_bloc.dart';
import 'package:flutter_application_login_with_bloc/src/view/components/loader.dart';
import 'package:flutter_application_login_with_bloc/src/view/components/spacers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.title, required this.username})
      : super(key: key);

  final String title;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeNav) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return LoadingWidget(
              child: initialLayout(context),
            );
          } else {
            return initialLayout(context);
          }
        },
      ),
    );
  }

  Widget initialLayout(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Bem vindo $username!",
              style: const TextStyle(fontSize: 50.00),
            ),
            const HeightSpacer(myHeight: 10.00),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context).add(NavBack());
                },
                child: const Text("Voltar para o login"))
          ],
        ),
      );
}