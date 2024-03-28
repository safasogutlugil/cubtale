import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_event.dart';
import '../../bloc/login/login_state.dart';
import '../../bloc/theme/theme_bloc.dart';
import '../../bloc/theme/theme_event.dart';
import '../error_dialog.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            showDialog(
              context: context,
              barrierDismissible: false, 
              builder: (BuildContext context) {
                return ErrorDialog(message: state.errorMessage!);
              },
            ).then((_) =>
                BlocProvider.of<LoginBloc>(context).add(ResetErrorEvent()));
            ;
          }
          if (state.isLoggedIn) {
            Navigator.of(context).pushReplacementNamed('/analytics');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leadingWidth: 320,
              leading: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                      'assets/images/cubtale-logo1.png'), 
                  Image.asset(
                      'assets/images/Cubtale-watermark.png'),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: () => themeBloc.add(ThemeToggle()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          themeBloc.state.themeData.brightness ==
                                  Brightness.light
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          themeBloc.state.themeData.brightness ==
                                  Brightness.light
                              ? 'Dark Mode'
                              : 'Light Mode',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [LoginCard()],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  LoginCard({Key? key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);

    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Card(
        margin: EdgeInsets.all(16.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Username',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Password',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus(); 
                    loginBloc.add(LoginUsernameChanged(
                        username: _usernameController.text));
                    loginBloc.add(LoginPasswordChanged(
                        password: _passwordController.text));
                    loginBloc.add(LoginSubmitted());
                  },
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
