import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:m_stock_opname/routers/router_utils.dart';
import 'package:m_stock_opname/services/app_db.dart';
import 'package:m_stock_opname/utils/app_theme.dart';
import 'package:m_stock_opname/utils/locator.dart';
import 'package:m_stock_opname/utils/sharedpreference_helper.dart';
import 'package:m_stock_opname/utils/utils.dart';
import 'package:m_stock_opname/widget/password_textfield.dart';

import '../utils/values.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final database = locator<AppDB>();

  final _etUsernameController = TextEditingController();
  final _etPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _etUsernameController.dispose();
    _etPasswordController.dispose();
  }

  void doLogin(String username, String password) async {
    String message = '';
    if (username.isEmpty || username.length == 0) {
      message = 'Username can\'t be empty';
    } else if (password.isEmpty || password.length == 0) {
      message = 'Password can\'t be empty';
    } else {
      database.usersDao.findUser(username).listen((event) {
        if (event != null) {
          if (Crypt(event.password.toString()).match(password)) {
            message = 'Logged In';
            SharedpreferenceHelper.setBoolPref(
                SharedpreferenceHelper.isLoggedIn, true);
            SharedpreferenceHelper.setStringPref(
                SharedpreferenceHelper.username, username);
            SharedpreferenceHelper.setStringPref(
                SharedpreferenceHelper.full_name, event.full_name.toString());
            context.goNamed(APP_PAGE.home.routeName);
          } else {
            message = 'Incorrect Password';
          }
        } else {
          message = 'User not found, pleaser register first!';
        }

        showToast(message);
      });
    }

    if (message.isNotEmpty) {
      showToast(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              height: 200,
              image: AssetImage('assets/images/official_logo.png'),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: Values.inputHeight,
              child: TextField(
                controller: _etUsernameController,
                decoration: AppTheme.getInputDecoration('username'),
                onChanged: (text) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            PasswordTextfield(
                controller: _etPasswordController, placeholder: "password"),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: FilledButton(
                onPressed: () {
                  doLogin(
                      _etUsernameController.text, _etPasswordController.text);
                },
                child: const Text(
                  'Login',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text('or haven\'t registered?'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: OutlinedButton(
                onPressed: () => {context.goNamed(APP_PAGE.register.routeName)},
                child: const Text(
                  'Register',
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
